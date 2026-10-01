namespace HomeLibrary.Web.Models;

/// <summary>Книга целиком - результат Book_GetById.</summary>
public class Book
{
    public int Id { get; set; }
    public string Title { get; set; } = "";
    public string Author { get; set; } = "";
    public short? PublishYear { get; set; }
    public string? Publisher { get; set; }
    public string? Isbn { get; set; }
    public string? Genre { get; set; }
    public int? PageCount { get; set; }
    public string? Notes { get; set; }
    public string? TableOfContents { get; set; }
}
