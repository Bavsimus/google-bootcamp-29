import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  final String author;
  final String imageUrl;
  final String name;

  Book({required this.author, required this.imageUrl, required this.name});

  factory Book.fromDocument(DocumentSnapshot doc) {
    return Book(
      author: doc['bookAuthor'],
      imageUrl: doc['bookImage'],
      name: doc['bookName'],
    );
  }
}
