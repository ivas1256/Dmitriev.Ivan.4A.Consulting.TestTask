namespace HomeLibrary.Web.Data;

/// <summary>Книга не найдена (процедура вернула ошибку 50404).</summary>
public class BookNotFoundException(int id) : Exception($"Книга с Id = {id} не найдена.");
