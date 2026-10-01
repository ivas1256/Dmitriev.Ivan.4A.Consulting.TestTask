using System.Xml;
using System.Xml.Linq;
using HomeLibrary.Web.Data;
using HomeLibrary.Web.Models;

namespace HomeLibrary.Web.Services;

/// <summary>Проверка и нормализация данных перед вызовом хранимых процедур.</summary>
public interface IBookService
{
    Task<IReadOnlyList<BookListItem>> SearchAsync(string? query, string searchIn);
    Task<Book?> GetByIdAsync(int id);
    Task<int> CreateAsync(BookEditModel book);
    Task UpdateAsync(int id, BookEditModel book);
    Task DeleteAsync(int id);
    string? FormatTableOfContents(string? xml);
}

public class BookService(IBookRepository repository) : IBookService
{
    private const string TocRootElement = "toc";
    private const int MaxTocLength = 1_000_000;

    public Task<IReadOnlyList<BookListItem>> SearchAsync(string? query, string searchIn)
    {
        if (!BookListViewModel.SearchFields.Any(f => f.Value == searchIn)) 
            searchIn = "all";

        return repository.SearchAsync(query?.Trim(), searchIn);
    }

    public Task<Book?> GetByIdAsync(int id) => repository.GetByIdAsync(id);

    public Task<int> CreateAsync(BookEditModel book)
    {
        book.TableOfContents = NormalizeTableOfContents(book.TableOfContents);
        return repository.InsertAsync(book);
    }

    public Task UpdateAsync(int id, BookEditModel book)
    {
        book.TableOfContents = NormalizeTableOfContents(book.TableOfContents);
        return repository.UpdateAsync(id, book);
    }

    public Task DeleteAsync(int id) => repository.DeleteAsync(id);

    /// <summary>
    /// Оглавление с отступами - для редактора
    /// </summary>
    public string? FormatTableOfContents(string? xml) =>
        string.IsNullOrWhiteSpace(xml) ? xml : XElement.Parse(xml).ToString();

    /// <summary>
    /// Проверяет, что оглавление - корректный XML с корнем toc, и убирает XML-декларацию:
    /// Пустое оглавление - null.
    /// </summary>
    private string? NormalizeTableOfContents(string? xml)
    {
        if (string.IsNullOrWhiteSpace(xml))
            return null;
        if (xml.Length > MaxTocLength)
            throw new BookValidationException("Оглавление слишком большое (не более 1 000 000 символов).");

        XDocument document;
        try
        {
            using var reader = XmlReader.Create(new StringReader(xml));
            document = XDocument.Load(reader);
        }
        catch (XmlException ex)
        {
            throw new BookValidationException($"Оглавление не является корректным XML: {ex.Message}");
        }

        if (document.Root!.Name != TocRootElement)
            throw new BookValidationException($"Корневой элемент оглавления должен быть <{TocRootElement}>, а не <{document.Root.Name}>.");

        return document.Root.ToString();
    }
}
