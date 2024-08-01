import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:libhub/ui/home_ui/book.dart';

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

  Future<void> _fetchBooks() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final uid = currentUser.uid;

      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('personalLibrary')
          .snapshots()
          .listen((snapshot) {
        final books =
            snapshot.docs.map((doc) => Book.fromDocument(doc)).toList();
        _books = books;
        _filteredBooks = books;
        notifyListeners();
      });
    } else {
      // Handle case where there is no current user (e.g., user is not logged in)
      _books = [];
      _filteredBooks = [];
      notifyListeners();
    }
  }

  void filterBooks(String searchText) {
    _searchText = searchText;
    _filteredBooks = _books
        .where((book) =>
            book.name.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    notifyListeners();
  }

}
