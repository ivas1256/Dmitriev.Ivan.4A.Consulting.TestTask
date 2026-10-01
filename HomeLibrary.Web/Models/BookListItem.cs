namespace HomeLibrary.Web.Models;

/// <summary>Строка списка - результат Book_Search (без оглавления).</summary>
public class BookListItem
{
    public int Id { get; set; }
    public string Title { get; set; } = "";
    public string Author { get; set; } = "";
    public short? PublishYear { get; set; }
    public string? Genre { get; set; }
}
