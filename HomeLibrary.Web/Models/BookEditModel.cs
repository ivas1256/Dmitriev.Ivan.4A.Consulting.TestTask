using System.ComponentModel.DataAnnotations;

namespace HomeLibrary.Web.Models;

/// <summary>Данные формы создания/изменения книги.</summary>
public class BookEditModel
{
    [Display(Name = "Название")]
    [Required(ErrorMessage = "Укажите название.")]
    [StringLength(300, ErrorMessage = "Название - не длиннее 300 символов.")]
    public string Title { get; set; } = "";

    [Display(Name = "Автор")]
    [Required(ErrorMessage = "Укажите автора.")]
    [StringLength(200, ErrorMessage = "Автор - не длиннее 200 символов.")]
    public string Author { get; set; } = "";

    [Display(Name = "Год издания")]
    [Range(1450, short.MaxValue, ErrorMessage = "Год издания - не раньше 1450.")]
    [NotInFutureYear]
    public short? PublishYear { get; set; }

    [Display(Name = "Издательство")]
    [StringLength(200, ErrorMessage = "Издательство - не длиннее 200 символов.")]
    public string? Publisher { get; set; }

    [Display(Name = "ISBN")]
    [StringLength(20, ErrorMessage = "ISBN - не длиннее 20 символов.")]
    public string? Isbn { get; set; }

    [Display(Name = "Жанр")]
    [StringLength(100, ErrorMessage = "Жанр - не длиннее 100 символов.")]
    public string? Genre { get; set; }

    [Display(Name = "Страниц")]
    [Range(1, int.MaxValue, ErrorMessage = "Число страниц должно быть больше нуля.")]
    public int? PageCount { get; set; }

    [Display(Name = "Заметки")]
    public string? Notes { get; set; }

    /// <summary>Оглавление в виде XML-текста с корневым элементом toc</summary>
    [Display(Name = "Оглавление (XML)")]
    public string? TableOfContents { get; set; }
}
