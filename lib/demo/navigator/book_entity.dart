class Book {
  final String title;
  final String author;

  Book(this.title, this.author);
}

// Routes
abstract class BookRoutePath {}

class BooksListPath extends BookRoutePath {}

class BooksSettingsPath extends BookRoutePath {}

class BooksDetailsPath extends BookRoutePath {
  final int id;

  BooksDetailsPath(this.id);
}