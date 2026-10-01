using HomeLibrary.Web.Data;
using HomeLibrary.Web.Models;
using HomeLibrary.Web.Services;
using Microsoft.AspNetCore.Mvc;

namespace HomeLibrary.Web.Controllers;

public class BooksController(IBookService books) : Controller
{
    // Список с поиском
    public async Task<IActionResult> Index(string? query, string searchIn = "all")
    {
        var model = new BookListViewModel
        {
            Query = query,
            SearchIn = searchIn,
            Books = await books.SearchAsync(query, searchIn)
        };
        return View(model);
    }

    // Карточка (просмотр)
    public async Task<IActionResult> Details(int id)
    {
        var book = await books.GetByIdAsync(id);
        return book is null ? NotFound() : View(book);
    }

    public IActionResult Create() => EditView(null, new BookEditModel());

    [HttpPost]
    public async Task<IActionResult> Create(BookEditModel model)
    {
        if (ModelState.IsValid)
        {
            try
            {
                var id = await books.CreateAsync(model);
                return RedirectToAction(nameof(Details), new { id });
            }
            catch (BookValidationException ex)
            {
                ModelState.AddModelError("", ex.Message);
            }
        }
        return EditView(null, model);
    }

    public async Task<IActionResult> Edit(int id)
    {
        var book = await books.GetByIdAsync(id);
        if (book is null)
            return NotFound();

        return EditView(id, new BookEditModel
        {
            Title = book.Title,
            Author = book.Author,
            PublishYear = book.PublishYear,
            Publisher = book.Publisher,
            Isbn = book.Isbn,
            Genre = book.Genre,
            PageCount = book.PageCount,
            Notes = book.Notes,
            TableOfContents = books.FormatTableOfContents(book.TableOfContents)
        });
    }

    [HttpPost]
    public async Task<IActionResult> Edit(int id, BookEditModel model)
    {
        if (ModelState.IsValid)
        {
            try
            {
                await books.UpdateAsync(id, model);
                return RedirectToAction(nameof(Details), new { id });
            }
            catch (BookValidationException ex)
            {
                ModelState.AddModelError("", ex.Message);
            }
            catch (BookNotFoundException)
            {
                return NotFound();
            }
        }
        return EditView(id, model);
    }

    [HttpPost]
    public async Task<IActionResult> Delete(int id)
    {
        try
        {
            await books.DeleteAsync(id);
        }
        catch (BookNotFoundException)
        {
            return NotFound();
        }
        return RedirectToAction(nameof(Index));
    }

    // Создание и изменение - одна форма; id == null означает новую книгу.
    private ViewResult EditView(int? id, BookEditModel model)
    {
        ViewData["BookId"] = id;
        return View("Edit", model);
    }
}
