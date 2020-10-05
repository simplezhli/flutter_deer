class Book {
  final String title;
  final String author;

  Book(this.title, this.author);
}

class BookRoutePath {
  final int id;

  BookRoutePath.home() : id = null;

  BookRoutePath.details(this.id);

  bool get isHomePage => id == null;

  bool get isDetailsPage => id != null;
}
