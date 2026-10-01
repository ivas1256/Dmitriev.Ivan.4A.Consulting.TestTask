using Microsoft.AspNetCore.Mvc.Rendering;

namespace HomeLibrary.Web.Models;

/// <summary>Страница списка: параметры поиска и найденные книги.</summary>
public class BookListViewModel
{
    public static readonly SelectListItem[] SearchFields =
    [
        new("везде", "all"),
        new("в названии", "title"),
        new("в авторе", "author"),
        new("в оглавлении", "toc")
    ];

    public string? Query { get; set; }
    public string SearchIn { get; set; } = "all";
    public IReadOnlyList<BookListItem> Books { get; set; } = [];
}
