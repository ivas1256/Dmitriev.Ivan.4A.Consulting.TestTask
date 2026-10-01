namespace HomeLibrary.Web.Services;

/// <summary>Ошибка входных данных; текст показывается пользователю.</summary>
public class BookValidationException(string message) : Exception(message);
