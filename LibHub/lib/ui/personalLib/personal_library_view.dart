import 'dart:math'; // Rastgele kitap seçimi için gerekli
import 'package:flutter/material.dart';
import 'package:libhub/core/services/firebase_services.dart';
import 'package:libhub/ui/personalLib/personal_library_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:libhub/ui/home_ui/book.dart';

class PersonalLibraryView extends StatefulWidget {
  @override
  _PersonalLibraryViewState createState() => _PersonalLibraryViewState();
}

class _PersonalLibraryViewState extends State<PersonalLibraryView> {
  final TextEditingController _searchController = TextEditingController();
  final firebaseService = FirebaseService();

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
                  hintText: 'Search in your library..',
                  hintStyle: TextStyle(color: Colors.orange[600]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                  prefixIcon: Icon(Icons.search, color: Colors.orange),
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
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Container(
                    margin: EdgeInsets.all(8),
                    child: GestureDetector(
                      onTap: () async => _showBookDialog(
                          context,
                          book,
                          await firebaseService.isBookInFavorites(
                              bookName: book.name, bookAuthor: book.author)),
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
                              color: Colors.orange[900],
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
                                color: Colors.orange,
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

  void _showBookDialog(BuildContext context, Book book, bool isLiked) async {
    bool isPressed_remove = false;
    bool isPressed_like = false;

    bool isFavorite = await firebaseService
        .isBookInFavorites(bookName: book.name, bookAuthor: book.author)
        .then((value) => isPressed_like = value);

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
                        color: Colors.orange,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Column(
                          children: [
                            Text("Mark as",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.red,
                                )),
                            Text("Favorite",
                                style:
                                    TextStyle(fontSize: 16, color: Colors.red)),
                          ],
                        ),
                        SizedBox(width: 16),
                        InkWell(
                          borderRadius: BorderRadius.circular(35),
                          onTap: () {
                            setState(() {
                              isPressed_like =
                                  !isPressed_like; // Tıklama durumunu değiştirir
                              firebaseService.AddBookToFavorites(
                                bookName: book.name,
                                bookAuthor: book.author,
                                bookImage: book.imageUrl,
                                context: context,
                              );
                            });
                            // Butona tıklandığında animasyon
                            Future.delayed(Duration(milliseconds: 300), () {
                              Navigator.of(context).pop(); // Dialog'u kapatır.
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(
                                12), // Container'ın içindeki boşluk
                            decoration: BoxDecoration(
                              color: isPressed_like
                                  ? Colors.red
                                  : Colors
                                      .transparent, // Tıklama durumuna göre arka plan rengi
                              shape:
                                  BoxShape.circle, // Container'ın şekli daire
                              border: Border.all(
                                color: Colors.red, // Kenarlık rengi kırmızı
                                width: 2, // Kenarlık kalınlığı 2 birim
                              ),
                            ),
                            child: Icon(
                              isPressed_like
                                  ? Icons.heart_broken
                                  : Icons
                                      .favorite, // Tıklama durumuna göre ikon
                              color: isPressed_like
                                  ? Colors.white
                                  : Colors
                                      .red, // Tıklama durumuna göre ikon rengi
                              size: 32, // İkon boyutu 32 birim
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Column(
                          children: [
                            Text("Remove Book From",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.orange,
                                )),
                            Text("Personal Library",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.orange)),
                          ],
                        ),
                        SizedBox(width: 16),
                        InkWell(
                          borderRadius: BorderRadius.circular(35),
                          onTap: () {
                            setState(() {
                              isPressed_remove =
                                  !isPressed_remove; // Tıklama durumunu değiştirir
                              firebaseService.removeBookFromPersonalLib(
                                  bookName: book.name, bookAuthor: book.author);
                            });
                            // Butona tıklandığında animasyon
                            Future.delayed(Duration(milliseconds: 300), () {
                              Navigator.of(context).pop(); // Dialog'u kapatır.
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isPressed_remove
                                  ? Colors.orange
                                  : Colors
                                      .transparent, // Tıklama durumuna göre renk
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.orange, // İkonun rengi
                                width: 2, // Sınır kalınlığı
                              ),
                            ),
                            child: Icon(
                              Icons.remove_circle_outline,
                              color: isPressed_remove
                                  ? Colors.white
                                  : Colors
                                      .orange, // Tıklama durumuna göre ikon rengi
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
