import 'package:stacked/stacked.dart';

class Book {
  final String title;
  final String author;
  final String coverUrl;

  Book(this.title, this.author, this.coverUrl);
}

class PersonalLibraryViewModel extends BaseViewModel {
  final List<Book> _books = [
    Book('The Great Gatsby', 'F. Scott Fitzgerald',
        'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/The_Great_Gatsby_Cover_1925_Retouched.jpg/800px-The_Great_Gatsby_Cover_1925_Retouched.jpg'),
    Book('1984', 'George Orwell',
        'https://m.media-amazon.com/images/I/61NAx5pd6XL._AC_UF1000,1000_QL80_.jpg'),
    Book('The Great Gatsby', 'F. Scott Fitzgerald',
        'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/The_Great_Gatsby_Cover_1925_Retouched.jpg/800px-The_Great_Gatsby_Cover_1925_Retouched.jpg'),
    Book('The Great Gatsby', 'F. Scott Fitzgerald',
        'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/The_Great_Gatsby_Cover_1925_Retouched.jpg/800px-The_Great_Gatsby_Cover_1925_Retouched.jpg'),
    Book('The Great Gatsby', 'F. Scott Fitzgerald',
        'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/The_Great_Gatsby_Cover_1925_Retouched.jpg/800px-The_Great_Gatsby_Cover_1925_Retouched.jpg'),
    Book('The Great Gatsby', 'F. Scott Fitzgerald',
        'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/The_Great_Gatsby_Cover_1925_Retouched.jpg/800px-The_Great_Gatsby_Cover_1925_Retouched.jpg'),
  ];

  List<Book> get books => _books;

  void addBook(String title, String author, String coverUrl) {
    _books.add(Book(title, author, coverUrl));
    notifyListeners();
  }
}