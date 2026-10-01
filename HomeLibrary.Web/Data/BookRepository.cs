using System.Data;
using Dapper;
using HomeLibrary.Web.Models;
using Microsoft.Data.SqlClient;

namespace HomeLibrary.Web.Data;

/// <summary>Доступ к данным только через хранимые процедуры dbo.Book_*.</summary>
public interface IBookRepository
{
    Task<IReadOnlyList<BookListItem>> SearchAsync(string? query, string searchIn);
    Task<Book?> GetByIdAsync(int id);
    Task<int> InsertAsync(BookEditModel book);
    Task UpdateAsync(int id, BookEditModel book);
    Task DeleteAsync(int id);
}

public class BookRepository(ISqlConnectionFactory connectionFactory) : IBookRepository
{
    // Номер ошибки, которой процедуры Book_Update и Book_Delete сообщают «книга не найдена».
    private const int NOT_FOUND_ERROR_CODE = 50404;

    public async Task<IReadOnlyList<BookListItem>> SearchAsync(string? query, string searchIn)
    {
        await using var connection = connectionFactory.Create();
        var rows = await connection.QueryAsync<BookListItem>(
            "dbo.Book_Search",
            new { Query = query, SearchIn = searchIn },
            commandType: CommandType.StoredProcedure);
        return rows.AsList();
    }

    public async Task<Book?> GetByIdAsync(int id)
    {
        await using var connection = connectionFactory.Create();
        return await connection.QuerySingleOrDefaultAsync<Book>(
            "dbo.Book_GetById", new { Id = id }, commandType: CommandType.StoredProcedure);
    }

    public async Task<int> InsertAsync(BookEditModel book)
    {
        await using var connection = connectionFactory.Create();
        return await connection.ExecuteScalarAsync<int>(
            "dbo.Book_Insert", ToParameters(book), commandType: CommandType.StoredProcedure);
    }

    public async Task UpdateAsync(int id, BookEditModel book)
    {
        var parameters = ToParameters(book);
        parameters.Add("Id", id);

        await using var connection = connectionFactory.Create();
        try
        {
            await connection.ExecuteAsync(
                "dbo.Book_Update", parameters, commandType: CommandType.StoredProcedure);
        }
        catch (SqlException ex) when (ex.Number == NOT_FOUND_ERROR_CODE)
        {
            throw new BookNotFoundException(id);
        }
    }

    public async Task DeleteAsync(int id)
    {
        await using var connection = connectionFactory.Create();
        try
        {
            await connection.ExecuteAsync(
                "dbo.Book_Delete", new { Id = id }, commandType: CommandType.StoredProcedure);
        }
        catch (SqlException ex) when (ex.Number == NOT_FOUND_ERROR_CODE)
        {
            throw new BookNotFoundException(id);
        }
    }

    private DynamicParameters ToParameters(BookEditModel book)
    {
        var parameters = new DynamicParameters();
        parameters.Add("Title", book.Title);
        parameters.Add("Author", book.Author);
        parameters.Add("PublishYear", book.PublishYear);
        parameters.Add("Publisher", book.Publisher);
        parameters.Add("Isbn", book.Isbn);
        parameters.Add("Genre", book.Genre);
        parameters.Add("PageCount", book.PageCount);
        parameters.Add("Notes", book.Notes);
        parameters.Add("TableOfContents", book.TableOfContents, DbType.Xml);
        return parameters;
    }
}
