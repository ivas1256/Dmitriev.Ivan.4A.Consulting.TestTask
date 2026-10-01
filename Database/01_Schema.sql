IF DB_ID(N'HomeLibrary') IS NULL
    CREATE DATABASE HomeLibrary;
GO

USE HomeLibrary;
GO

IF OBJECT_ID(N'dbo.Books', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Books
    (
        Id              int IDENTITY(1, 1) NOT NULL,
        Title           nvarchar(300)      NOT NULL,
        Author          nvarchar(200)      NOT NULL,
        PublishYear     smallint           NULL,
        Publisher       nvarchar(200)      NULL,
        Isbn            nvarchar(20)       NULL,
        Genre           nvarchar(100)      NULL,
        PageCount       int                NULL,
        Notes           nvarchar(max)      NULL,
        -- Оглавление: <toc><chapter page="..."><title>...</title><section>...</section></chapter></toc>
        TableOfContents xml                NULL,
        CreatedAt       datetime2(0)       NOT NULL CONSTRAINT DF_Books_CreatedAt DEFAULT SYSUTCDATETIME(),
        UpdatedAt       datetime2(0)       NOT NULL CONSTRAINT DF_Books_UpdatedAt DEFAULT SYSUTCDATETIME(),

        CONSTRAINT PK_Books PRIMARY KEY CLUSTERED (Id),
        CONSTRAINT CK_Books_Title_NotEmpty  CHECK (LEN(Title) > 0),
        CONSTRAINT CK_Books_Author_NotEmpty CHECK (LEN(Author) > 0),
        CONSTRAINT CK_Books_PublishYear     CHECK (PublishYear BETWEEN 1450 AND YEAR(GETDATE())),
        CONSTRAINT CK_Books_PageCount       CHECK (PageCount > 0)
    );
END
GO

SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO

-- Создание книги. Возвращает Id новой записи.
CREATE OR ALTER PROCEDURE dbo.Book_Insert
    @Title           nvarchar(300),
    @Author          nvarchar(200),
    @PublishYear     smallint      = NULL,
    @Publisher       nvarchar(200) = NULL,
    @Isbn            nvarchar(20)  = NULL,
    @Genre           nvarchar(100) = NULL,
    @PageCount       int           = NULL,
    @Notes           nvarchar(max) = NULL,
    @TableOfContents xml           = NULL
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.Books (Title, Author, PublishYear, Publisher, Isbn, Genre, PageCount, Notes, TableOfContents)
    VALUES (@Title, @Author, @PublishYear, @Publisher, @Isbn, @Genre, @PageCount, @Notes, @TableOfContents);

    SELECT CAST(SCOPE_IDENTITY() AS int) AS Id;
END
GO

-- Изменение книги. Если записи нет - ошибка 50404.
CREATE OR ALTER PROCEDURE dbo.Book_Update
    @Id              int,
    @Title           nvarchar(300),
    @Author          nvarchar(200),
    @PublishYear     smallint      = NULL,
    @Publisher       nvarchar(200) = NULL,
    @Isbn            nvarchar(20)  = NULL,
    @Genre           nvarchar(100) = NULL,
    @PageCount       int           = NULL,
    @Notes           nvarchar(max) = NULL,
    @TableOfContents xml           = NULL
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.Books
    SET Title           = @Title,
        Author          = @Author,
        PublishYear     = @PublishYear,
        Publisher       = @Publisher,
        Isbn            = @Isbn,
        Genre           = @Genre,
        PageCount       = @PageCount,
        Notes           = @Notes,
        TableOfContents = @TableOfContents,
        UpdatedAt       = SYSUTCDATETIME()
    WHERE Id = @Id;

    IF @@ROWCOUNT = 0
        THROW 50404, N'Книга не найдена.', 1;
END
GO

-- Удаление книги. Если записи нет - ошибка 50404.
CREATE OR ALTER PROCEDURE dbo.Book_Delete
    @Id int
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM dbo.Books WHERE Id = @Id;

    IF @@ROWCOUNT = 0
        THROW 50404, N'Книга не найдена.', 1;
END
GO

-- Карточка книги со всеми полями, включая оглавление.
CREATE OR ALTER PROCEDURE dbo.Book_GetById
    @Id int
AS
BEGIN
    SET NOCOUNT ON;

    SELECT Id, Title, Author, PublishYear, Publisher, Isbn, Genre, PageCount, Notes,
           TableOfContents, CreatedAt, UpdatedAt
    FROM dbo.Books
    WHERE Id = @Id;
END
GO

-- Список книг с поиском (без оглавления).
--   @SearchIn: all | title | author | toc
CREATE OR ALTER PROCEDURE dbo.Book_Search
    @Query    nvarchar(200) = NULL,
    @SearchIn varchar(10)   = 'all'
AS
BEGIN
    SET NOCOUNT ON;

    SET @Query = NULLIF(LTRIM(RTRIM(@Query)), N'');

    DECLARE @Pattern nvarchar(202) = N'%' + @Query + N'%';

    SELECT b.Id, b.Title, b.Author, b.PublishYear, b.Genre
    FROM dbo.Books AS b
    WHERE @Query IS NULL
       OR (@SearchIn IN ('all', 'title')  AND b.Title  LIKE @Pattern)
       OR (@SearchIn IN ('all', 'author') AND b.Author LIKE @Pattern)
       OR (@SearchIn IN ('all', 'toc') AND EXISTS (
              SELECT 1
              FROM b.TableOfContents.nodes('//text()') AS t(n)
              WHERE t.n.value('.', 'nvarchar(max)') LIKE @Pattern))
    ORDER BY b.Title, b.Id
END
GO
