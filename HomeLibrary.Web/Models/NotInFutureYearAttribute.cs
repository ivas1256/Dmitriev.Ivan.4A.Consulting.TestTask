using System.ComponentModel.DataAnnotations;

namespace HomeLibrary.Web.Models;

/// <summary>Год не позже текущего (у Range граница должна быть константой).</summary>
public class NotInFutureYearAttribute : ValidationAttribute
{
    public override bool IsValid(object? value) => value is not short year || year <= DateTime.Today.Year;

    public override string FormatErrorMessage(string name) =>
        $"Год издания не может быть больше {DateTime.Today.Year}.";
}
