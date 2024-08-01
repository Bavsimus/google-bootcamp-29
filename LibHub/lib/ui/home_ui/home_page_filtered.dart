import 'dart:math'; // Rastgele kitap seçimi için gerekli
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:libhub/core/services/firebase_services.dart';
import 'package:libhub/ui/home_ui/home_page_filtered_view_model.dart';
import 'package:stacked/stacked.dart';

import 'book.dart';

class BookListScreen extends StatefulWidget {
  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  final firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BookListViewModel>.reactive(
      viewModelBuilder: () => BookListViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        body: _buildPopularList(context, viewModel),
      ),
    );
  }

  Widget _buildPopularList(BuildContext context, BookListViewModel viewModel) {
    final random = Random();

    // 5 rastgele kitap seçiyoruz
    List<Book> allBooks = List<Book>.from(viewModel.filteredBooks);
    allBooks.shuffle(random);
    final popularBooks = allBooks.take(5).toList();

    // 5 rastgele kitap için ikinci liste oluşturuyoruz
    List<Book> additionalBooks = List<Book>.from(viewModel.filteredBooks);
    additionalBooks.shuffle(random);
    final featuredBooks = additionalBooks.take(5).toList();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(
                  Icons.travel_explore, // İkonu buraya ekliyoruz
                  color: Colors.purple,
                  size: 30,
                ),
                SizedBox(width: 8),
                Text(
                  'Popular These Days',
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height *
                0.4, // Yüksekliği ayarlayın
            child: popularBooks.isEmpty
                ? Center(child: Text('No popular books found'))
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: popularBooks.map((book) {
                        return Card(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.55,
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: Container(
                              margin: EdgeInsets.all(8),
                              child: GestureDetector(
                                onTap: () => _showBookDialog(context, book),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        book.imageUrl,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        book.name,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.purple[500]),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        book.author,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.purple[300]),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(
                  Icons.diversity_1, // İkonu buraya ekliyoruz
                  color: Colors.purple,
                  size: 30,
                ),
                SizedBox(width: 8),
                Text(
                  'New From Friends',
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height *
                0.4, // Yüksekliği ayarlayın
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: featuredBooks.map((book) {
                  return Card(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Container(
                        margin: EdgeInsets.all(8),
                        child: GestureDetector(
                          onTap: () => _showBookDialog(context, book),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  book.imageUrl,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  book.name,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.purple[500]),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  book.author,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.purple[300]),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showBookDialog(BuildContext context, Book book) {
    bool isPressed = false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 16,
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(book.imageUrl,
                          height: 200, fit: BoxFit.cover),
                    ),
                    SizedBox(height: 8),
                    Text(
                      book.name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      book.author,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 16),
                    // Text(
                    //   "Here you can add a description or any other details about the book.",
                    //   textAlign: TextAlign.center,
                    //   style: TextStyle(fontSize: 16),
                    // ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Column(
                          children: [
                            Text("Add Book To",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.purple)),
                            Text("Personal Library",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.purple)),
                          ],
                        ),
                        SizedBox(width: 16),
                        InkWell(
                          borderRadius: BorderRadius.circular(35),
                          onTap: () {
                            setState(() {
                              isPressed =
                                  !isPressed; // Tıklama durumunu değiştirir
                              firebaseService.saveBookToPersonalLib(
                                bookName: book.name,
                                bookAuthor: book.author,
                                bookImage: book.imageUrl,
                              );
                            });
                            // Butona tıklandığında animasyon
                            Future.delayed(Duration(milliseconds: 300), () {
                              Navigator.of(context).pop(); // Dialog'u kapatır.
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isPressed
                                  ? Colors.purple
                                  : Colors
                                      .transparent, // Tıklama durumuna göre renk
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.purple, // İkonun rengi
                                width: 2, // Sınır kalınlığı
                              ),
                            ),
                            child: Icon(
                              Icons.add_circle_outline,
                              color: isPressed
                                  ? Colors.white
                                  : Colors
                                      .purple, // Tıklama durumuna göre ikon rengi
                              size: 32, // İkonun boyutu
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
