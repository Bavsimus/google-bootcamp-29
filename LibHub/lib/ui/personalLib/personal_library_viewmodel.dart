import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:libhub/home_ui/book.dart';

class BookListViewModel extends BaseViewModel {
  String _searchText = "";
  List<Book> _books = [];
  List<Book> _filteredBooks = [];
  List<Book> _favorites = [];

  String get searchText => _searchText;
  List<Book> get books => _books;
  List<Book> get filteredBooks => _filteredBooks;
  List<Book> get favorites => _favorites;

  BookListViewModel() {
    _fetchBooks();
  }

  void _fetchBooks() {
    FirebaseFirestore.instance
        .collection('books')
        .snapshots()
        .listen((snapshot) {
      final books = snapshot.docs.map((doc) => Book.fromDocument(doc)).toList();
      _books = books;
      _filteredBooks = books;
      notifyListeners();
    });
  }

  void filterBooks(String searchText) {
    _searchText = searchText;
    _filteredBooks = _books
        .where((book) =>
            book.name.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void addToFavorites(Book book) {
    if (!_favorites.contains(book)) {
      _favorites.add(book);
      notifyListeners();
    }
  }

  void removeFromFavorites(Book book) {
    _favorites.remove(book);
    notifyListeners();
  }
}
