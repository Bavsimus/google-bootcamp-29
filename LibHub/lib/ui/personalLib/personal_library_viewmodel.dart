import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stacked/stacked.dart';

class Book {
  final String title;
  final String author;
  final String coverUrl;

  Book(this.title, this.author, this.coverUrl);

  // Firestore'dan alınan veriyi Book nesnesine dönüştüren factory metodu
  factory Book.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Book(
      data['bookName'] ?? '',
      data['bookAuthor'] ?? '',
      data['bookImage'] ?? '',
    );
  }
}

class PersonalLibraryViewModel extends BaseViewModel {
  List<Book> _books = [];
  List<Book> _favoriteBooks = [];
  String _mostReadCategory = 'Fiction';
  String _userName = 'John Doe';
  String _userEmail = 'john.doe@example.com';
  String _searchQuery = '';

  List<Book> get books => _books;
  List<Book> get favoriteBooks => _favoriteBooks;
  String get mostReadCategory => _mostReadCategory;
  String get userName => _userName;
  String get userEmail => _userEmail;

  // Firestore referansı
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Arama sorgusuna göre filtrelenmiş kitapları döndüren getter
  List<Book> get filteredBooks => _searchQuery.isEmpty
      ? _books
      : _books
          .where((book) =>
              book.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              book.author.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();

  // Arama sorgusunu güncelleyen metod
  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  // Firestore'dan kitapları çeken metod
  Future<void> fetchBooks() async {
    setBusy(true);
    try {
      QuerySnapshot snapshot = await _firestore.collection('books').get();
      _books = snapshot.docs.map((doc) => Book.fromFirestore(doc)).toList();
      notifyListeners();
    } catch (e) {
      print(e);
    }
    setBusy(false);
  }

  // Belirli bir kullanıcının favori kitaplarını Firestore'dan çeken metod
  Future<void> fetchFavoriteBooks(String userId) async {
    setBusy(true);
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();
      List<dynamic> favoriteBookIds = userDoc['favoriteBooks'];

      List<Book> favoriteBooksList = [];
      for (String bookId in favoriteBookIds) {
        DocumentSnapshot bookDoc =
            await _firestore.collection('books').doc(bookId).get();
        favoriteBooksList.add(Book.fromFirestore(bookDoc));
      }

      _favoriteBooks = favoriteBooksList;
      notifyListeners();
    } catch (e) {
      print(e);
    }
    setBusy(false);
  }

  // Başlatma işlemi sırasında Firestore'dan verileri çek
  Future<void> initialize(String userId) async {
    await fetchBooks();
    await fetchFavoriteBooks(userId);
  }

  // Kitap ekleme metodunu Firestore'a eklemek için güncelle
  void addBook(String title, String author, String coverUrl) {
    Book newBook = Book(title, author, coverUrl);
    _books.add(newBook);
    notifyListeners();

    // Firestore'a ekleme
    _firestore.collection('books').add({
      'bookName': title,
      'bookAuthor': author,
      'bookImage': coverUrl,
    });
  }
}
