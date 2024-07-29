import 'dart:math'; // Rastgele kitap seçimi için gerekli
import 'package:flutter/material.dart';
import 'package:libhub/home_ui/home_page_filtered_view_model.dart';
import 'package:stacked/stacked.dart';

import 'book.dart';

class BookListScreen extends StatefulWidget {
  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BookListViewModel>.reactive(
      viewModelBuilder: () => BookListViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        body: Column(
          children: [
            TabBar(
              controller: _tabController,
              indicatorColor: const Color.fromARGB(255, 33, 116, 93),
              labelColor: const Color.fromARGB(255, 33, 116, 93),
              unselectedLabelColor: const Color.fromARGB(255, 80, 177, 149),
              tabs: const [
                Tab(text: 'Popular'),
                Tab(text: 'All Books'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildPopularList(context, viewModel),
                  _buildBookList(context, viewModel),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookList(BuildContext context, BookListViewModel viewModel) {
    int itemsPerRow = 5;
    int rowCount = (viewModel.filteredBooks.length / itemsPerRow).ceil();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: viewModel.filteredBooks.isEmpty
              ? Center(child: Text('No books found'))
              : ListView.builder(
                  itemCount: rowCount,
                  itemBuilder: (context, rowIndex) {
                    final rowBooks = viewModel.filteredBooks
                        .skip(rowIndex * itemsPerRow)
                        .take(itemsPerRow)
                        .toList();

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: rowBooks.map((book) {
                          return Card(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.55,
                              height: MediaQuery.of(context).size.height * 0.43,
                              child: Container(
                                margin: EdgeInsets.all(8),
                                child: GestureDetector(
                                  onTap: () => _showBookDialog(context, book),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Image.network(
                                        book.imageUrl,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          book.name,
                                          style: TextStyle(fontSize: 18),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          book.author,
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.grey),
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
                ),
        ),
      ],
    );
  }

  Widget _buildPopularList(BuildContext context, BookListViewModel viewModel) {
    int itemsPerRow = 5;
    int rowCount = (5 / itemsPerRow).ceil(); // 5 kitap için

    // 5 rastgele kitap seçiyoruz
    final random = Random();
    final popularBooks = List<Book>.from(viewModel.filteredBooks)
      ..shuffle(random)
      ..take(5).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Popular These Days',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Expanded(
          child: popularBooks.isEmpty
              ? Center(child: Text('No popular books found'))
              : ListView.builder(
                  itemCount: rowCount,
                  itemBuilder: (context, rowIndex) {
                    final rowBooks = popularBooks
                        .skip(rowIndex * itemsPerRow)
                        .take(itemsPerRow)
                        .toList();

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: rowBooks.map((book) {
                          return Card(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.55,
                              height: MediaQuery.of(context).size.height * 0.6,
                              child: Container(
                                margin: EdgeInsets.all(8),
                                child: GestureDetector(
                                  onTap: () => _showBookDialog(context, book),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Image.network(
                                        book.imageUrl,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          book.name,
                                          style: TextStyle(fontSize: 18),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          book.author,
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.grey),
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
                ),
        ),
      ],
    );
  }

  void _showBookDialog(BuildContext context, Book book) {
    showDialog(
      context: context,
      builder: (context) {
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
                Image.network(book.imageUrl, height: 200, fit: BoxFit.cover),
                SizedBox(height: 16),
                Text(
                  book.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  book.author,
                  style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                ),
                SizedBox(height: 16),
                Text(
                  "Here you can add a description or any other details about the book.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
