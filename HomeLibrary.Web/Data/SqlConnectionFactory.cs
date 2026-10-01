using Microsoft.Data.SqlClient;

namespace HomeLibrary.Web.Data;

/// <summary>Создаёт подключения к БД</summary>
public interface ISqlConnectionFactory
{
    SqlConnection Create();
}

public class SqlConnectionFactory(IConfiguration configuration) : ISqlConnectionFactory
{
    private readonly string _connectionString = configuration.GetConnectionString("HomeLibrary")
        ?? throw new InvalidOperationException("Не задана строка подключения ConnectionStrings:HomeLibrary.");

    public SqlConnection Create() => new(_connectionString);
}
