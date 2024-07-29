import 'dart:math'; // Rastgele kitap seçimi için gerekli
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:libhub/home_ui/home_page_filtered_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:libhub/home_ui/book.dart';

class AddBook extends StatefulWidget {
  @override
  _PersonalLibraryViewState createState() => _PersonalLibraryViewState();
}

class _PersonalLibraryViewState extends State<AddBook> {
  final TextEditingController _searchController = TextEditingController();
  String _searchTerm = "";

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchTerm = _searchController.text.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BookListViewModel>.reactive(
      viewModelBuilder: () => BookListViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Add by search..',
                  hintStyle: TextStyle(color: Colors.pink[600]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                  prefixIcon: Icon(Icons.search, color: Colors.pink),
                ),
                onChanged: (text) {
                  setState(() {
                    _searchTerm = text.toLowerCase();
                  });
                },
              ),
            ),
            Expanded(
              child: _buildBookList(context, viewModel),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookList(BuildContext context, BookListViewModel viewModel) {
    int itemsPerRow = 5;
    int rowCount = (viewModel.filteredBooks.length / itemsPerRow).ceil();

    final filteredBooks = viewModel.filteredBooks.where((book) {
      final bookTitle = book.name.toLowerCase();
      final bookAuthor = book.author.toLowerCase();
      return bookTitle.contains(_searchTerm) ||
          bookAuthor.contains(_searchTerm);
    }).toList();

    return ListView.builder(
      itemCount: (filteredBooks.length / itemsPerRow).ceil(),
      itemBuilder: (context, rowIndex) {
        final rowBooks = filteredBooks
            .skip(rowIndex * itemsPerRow)
            .take(itemsPerRow)
            .toList();

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: rowBooks.map((book) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: EdgeInsets.all(8),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.55,
                  height: MediaQuery.of(context).size.height * 0.43,
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
                          SizedBox(height: 8),
                          Text(
                            book.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink[900],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              book.author,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.pink,
                              ),
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
        );
      },
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
                    SizedBox(height: 16),
                    Text(
                      book.name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
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
                    Text(
                      "Here you can add a description or any other details about the book.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isPressed = !isPressed; // Tıklama durumunu değiştirir
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
                              ? Colors.pink
                              : Colors
                                  .transparent, // Tıklama durumuna göre renk
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.pink, // İkonun rengi
                            width: 2, // Sınır kalınlığı
                          ),
                        ),
                        child: Icon(
                          Icons.add_circle_outline,
                          color: isPressed
                              ? Colors.white
                              : Colors.pink, // Tıklama durumuna göre ikon rengi
                          size: 32, // İkonun boyutu
                        ),
                      ),
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
