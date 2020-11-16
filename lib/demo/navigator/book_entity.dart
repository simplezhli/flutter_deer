class Book {

  Book(this.title, this.author);

  final String title;
  final String author;
}

// Routes
abstract class BookRoutePath {}

class BooksListPath extends BookRoutePath {}

class BooksSettingsPath extends BookRoutePath {}

class BooksDetailsPath extends BookRoutePath {

  BooksDetailsPath(this.id);

  final int id;
}