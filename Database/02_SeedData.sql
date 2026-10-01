USE HomeLibrary;
GO

-- Тестовые данные. Добавляются только в пустую таблицу, через те же процедуры, что и приложение.
IF NOT EXISTS (SELECT 1 FROM dbo.Books)
BEGIN
    EXEC dbo.Book_Insert
        @Title = N'Преступление и наказание', @Author = N'Фёдор Достоевский', @PublishYear = 1866, @Genre = N'Роман',
        @TableOfContents = N'<toc>
  <chapter><title>Часть первая</title></chapter>
  <chapter><title>Часть вторая</title></chapter>
  <chapter><title>Часть третья</title></chapter>
  <chapter><title>Часть четвёртая</title></chapter>
  <chapter><title>Часть пятая</title></chapter>
  <chapter><title>Часть шестая</title></chapter>
  <chapter><title>Эпилог</title></chapter>
</toc>';

    EXEC dbo.Book_Insert
        @Title = N'Мастер и Маргарита', @Author = N'Михаил Булгаков', @PublishYear = 1967, @Genre = N'Роман',
        @Notes = N'Первая публикация - журнал «Москва», 1966–1967, с сокращениями.',
        @TableOfContents = N'<toc>
  <chapter>
    <title>Часть первая</title>
    <section><title>Глава 1. Никогда не разговаривайте с неизвестными</title></section>
    <section><title>Глава 2. Понтий Пилат</title></section>
    <section><title>Глава 3. Седьмое доказательство</title></section>
    <section><title>Глава 4. Погоня</title></section>
    <section><title>Глава 5. Было дело в Грибоедове</title></section>
    <section><title>Глава 6. Шизофрения, как и было сказано</title></section>
    <section><title>Глава 7. Нехорошая квартира</title></section>
    <section><title>Глава 8. Поединок между профессором и поэтом</title></section>
    <section><title>Глава 9. Коровьевские штуки</title></section>
    <section><title>Глава 10. Вести из Ялты</title></section>
    <section><title>Глава 11. Раздвоение Ивана</title></section>
    <section><title>Глава 12. Черная магия и ее разоблачение</title></section>
    <section><title>Глава 13. Явление героя</title></section>
    <section><title>Глава 14. Слава петуху!</title></section>
    <section><title>Глава 15. Сон Никанора Ивановича</title></section>
    <section><title>Глава 16. Казнь</title></section>
    <section><title>Глава 17. Беспокойный день</title></section>
    <section><title>Глава 18. Неудачливые визитеры</title></section>
  </chapter>
  <chapter>
    <title>Часть вторая</title>
    <section><title>Глава 19. Маргарита</title></section>
    <section><title>Глава 20. Крем Азазелло</title></section>
    <section><title>Глава 21. Полет</title></section>
    <section><title>Глава 22. При свечах</title></section>
    <section><title>Глава 23. Великий бал у сатаны</title></section>
    <section><title>Глава 24. Извлечение мастера</title></section>
    <section><title>Глава 25. Как прокуратор пытался спасти Иуду из Кириафа</title></section>
    <section><title>Глава 26. Погребение</title></section>
    <section><title>Глава 27. Конец квартиры №50</title></section>
    <section><title>Глава 28. Последние похождения Коровьева и Бегемота</title></section>
    <section><title>Глава 29. Судьба мастера и Маргариты определена</title></section>
    <section><title>Глава 30. Пора! Пора!</title></section>
    <section><title>Глава 31. На Воробьевых горах</title></section>
    <section><title>Глава 32. Прощение и вечный приют</title></section>
  </chapter>
  <chapter><title>Эпилог</title></chapter>
</toc>';

    EXEC dbo.Book_Insert
        @Title = N'Капитанская дочка', @Author = N'Александр Пушкин', @PublishYear = 1836, @Genre = N'Исторический роман',
        @TableOfContents = N'<toc>
  <chapter><title>Глава I. Сержант гвардии</title></chapter>
  <chapter><title>Глава II. Вожатый</title></chapter>
  <chapter><title>Глава III. Крепость</title></chapter>
  <chapter><title>Глава IV. Поединок</title></chapter>
  <chapter><title>Глава V. Любовь</title></chapter>
  <chapter><title>Глава VI. Пугачевщина</title></chapter>
  <chapter><title>Глава VII. Приступ</title></chapter>
  <chapter><title>Глава VIII. Незваный гость</title></chapter>
  <chapter><title>Глава IX. Разлука</title></chapter>
  <chapter><title>Глава X. Осада города</title></chapter>
  <chapter><title>Глава XI. Мятежная слобода</title></chapter>
  <chapter><title>Глава XII. Сирота</title></chapter>
  <chapter><title>Глава XIII. Арест</title></chapter>
  <chapter><title>Глава XIV. Суд</title></chapter>
</toc>';

    EXEC dbo.Book_Insert
        @Title = N'Евгений Онегин', @Author = N'Александр Пушкин', @PublishYear = 1833, @Genre = N'Роман в стихах',
        @TableOfContents = N'<toc>
  <chapter><title>Глава первая</title></chapter>
  <chapter><title>Глава вторая</title></chapter>
  <chapter><title>Глава третья</title></chapter>
  <chapter><title>Глава четвёртая</title></chapter>
  <chapter><title>Глава пятая</title></chapter>
  <chapter><title>Глава шестая</title></chapter>
  <chapter><title>Глава седьмая</title></chapter>
  <chapter><title>Глава восьмая</title></chapter>
  <chapter><title>Отрывки из путешествия Онегина</title></chapter>
</toc>';

    EXEC dbo.Book_Insert
        @Title = N'Герой нашего времени', @Author = N'Михаил Лермонтов', @PublishYear = 1840, @Genre = N'Роман',
        @TableOfContents = N'<toc>
  <chapter><title>Предисловие</title></chapter>
  <chapter>
    <title>Часть первая</title>
    <section><title>Бэла</title></section>
    <section><title>Максим Максимыч</title></section>
    <section>
      <title>Журнал Печорина</title>
      <section><title>Предисловие</title></section>
      <section><title>Тамань</title></section>
    </section>
  </chapter>
  <chapter>
    <title>Часть вторая</title>
    <section><title>Княжна Мери</title></section>
    <section><title>Фаталист</title></section>
  </chapter>
</toc>';

    EXEC dbo.Book_Insert
        @Title = N'Мцыри', @Author = N'Михаил Лермонтов', @PublishYear = 1840, @Genre = N'Поэма',
        @Notes = N'Поэма без деления на главы - оглавление не заполнено.';

    EXEC dbo.Book_Insert
        @Title = N'Война и мир', @Author = N'Лев Толстой', @PublishYear = 1869, @Genre = N'Роман-эпопея',
        @TableOfContents = N'<toc>
  <chapter><title>Том первый</title><section><title>Часть первая</title></section><section><title>Часть вторая</title></section><section><title>Часть третья</title></section></chapter>
  <chapter><title>Том второй</title><section><title>Часть первая</title></section><section><title>Часть вторая</title></section><section><title>Часть третья</title></section><section><title>Часть четвёртая</title></section><section><title>Часть пятая</title></section></chapter>
  <chapter><title>Том третий</title><section><title>Часть первая</title></section><section><title>Часть вторая</title></section><section><title>Часть третья</title></section></chapter>
  <chapter><title>Том четвёртый</title><section><title>Часть первая</title></section><section><title>Часть вторая</title></section><section><title>Часть третья</title></section><section><title>Часть четвёртая</title></section></chapter>
  <chapter><title>Эпилог</title><section><title>Часть первая</title></section><section><title>Часть вторая</title></section></chapter>
</toc>';

    EXEC dbo.Book_Insert
        @Title = N'Мёртвые души', @Author = N'Николай Гоголь', @PublishYear = 1842, @Genre = N'Поэма в прозе',
        @TableOfContents = N'<toc>
  <chapter>
    <title>Том первый</title>
    <section><title>Глава первая</title></section>
    <section><title>Глава вторая</title></section>
    <section><title>Глава третья</title></section>
    <section><title>Глава четвёртая</title></section>
    <section><title>Глава пятая</title></section>
    <section><title>Глава шестая</title></section>
    <section><title>Глава седьмая</title></section>
    <section><title>Глава восьмая</title></section>
    <section><title>Глава девятая</title></section>
    <section><title>Глава десятая</title></section>
    <section><title>Глава одиннадцатая</title></section>
  </chapter>
</toc>';

    EXEC dbo.Book_Insert
        @Title = N'Двенадцать стульев', @Author = N'Илья Ильф, Евгений Петров', @PublishYear = 1928, @Genre = N'Сатирический роман',
        @TableOfContents = N'<toc>
  <chapter><title>Часть первая. Старгородский лев</title></chapter>
  <chapter><title>Часть вторая. В Москве</title></chapter>
  <chapter><title>Часть третья. Сокровище мадам Петуховой</title></chapter>
</toc>';

    EXEC dbo.Book_Insert
        @Title = N'Чистый код. Создание, анализ и рефакторинг', @Author = N'Роберт Мартин', @PublishYear = 2008, @Genre = N'Программирование',
        @TableOfContents = N'<toc>
  <chapter><title>Глава 1. Чистый код</title></chapter>
  <chapter><title>Глава 2. Содержательные имена</title></chapter>
  <chapter><title>Глава 3. Функции</title></chapter>
  <chapter><title>Глава 4. Комментарии</title></chapter>
  <chapter><title>Глава 5. Форматирование</title></chapter>
  <chapter><title>Глава 6. Объекты и структуры данных</title></chapter>
  <chapter><title>Глава 7. Обработка ошибок</title></chapter>
  <chapter><title>Глава 8. Границы</title></chapter>
  <chapter><title>Глава 9. Модульные тесты</title></chapter>
  <chapter><title>Глава 10. Классы</title></chapter>
  <chapter><title>Глава 11. Системы</title></chapter>
  <chapter><title>Глава 12. Формирование архитектуры</title></chapter>
  <chapter><title>Глава 13. Многопоточность</title></chapter>
  <chapter><title>Глава 14. Последовательное очищение</title></chapter>
  <chapter><title>Глава 15. Внутреннее строение JUnit</title></chapter>
  <chapter><title>Глава 16. Переработка SerialDate</title></chapter>
  <chapter><title>Глава 17. Запахи и эвристические правила</title></chapter>
</toc>';

    EXEC dbo.Book_Insert
        @Title = N'Совершенный код', @Author = N'Стив Макконнелл', @PublishYear = 2004, @Genre = N'Программирование',
        @Notes = N'Второе издание.',
        @TableOfContents = N'<toc>
  <chapter><title>Часть I. Основы разработки ПО</title></chapter>
  <chapter><title>Часть II. Высококачественный код</title></chapter>
  <chapter><title>Часть III. Переменные</title></chapter>
  <chapter><title>Часть IV. Операторы</title></chapter>
  <chapter><title>Часть V. Усовершенствование кода</title></chapter>
  <chapter><title>Часть VI. Системные вопросы</title></chapter>
  <chapter><title>Часть VII. Мастерство программирования</title></chapter>
</toc>';
END
GO
