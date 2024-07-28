import 'package:flutter/material.dart';
import 'package:libhub/home_ui/home_page_filtered_view_model.dart';
import 'package:stacked/stacked.dart';

import 'book.dart';

class BookListScreen extends StatefulWidget {
  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> with SingleTickerProviderStateMixin {
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
        appBar: AppBar(
          title: TextField(
            decoration: InputDecoration(
              hintText: 'Search for a book',
              border: InputBorder.none,
            ),
            onChanged: viewModel.filterBooks,
          ),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'Books'),
              Tab(text: 'Favorites'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildBookList(context, viewModel),
            _buildFavoritesList(context, viewModel),
          ],
        ),
      ),
    );
  }

  Widget _buildBookList(BuildContext context, BookListViewModel viewModel) {
    int itemsPerRow = 5;
    int rowCount = (viewModel.filteredBooks.length / itemsPerRow).ceil();

    return viewModel.filteredBooks.isEmpty
        ? Center(child: Text('No books found'))
        : ListView.builder(
            itemCount: rowCount,
            itemBuilder: (context, rowIndex) {
              final rowBooks = viewModel.filteredBooks.skip(rowIndex * itemsPerRow).take(itemsPerRow).toList();

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
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    book.author,
                                    style: TextStyle(fontSize: 14, color: Colors.grey),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    viewModel.favorites.contains(book) ? Icons.favorite : Icons.favorite_border,
                                    color: viewModel.favorites.contains(book) ? Colors.red : Colors.grey,
                                  ),
                                  onPressed: () {
                                    if (viewModel.favorites.contains(book)) {
                                      viewModel.removeFromFavorites(book);
                                    } else {
                                      viewModel.addToFavorites(book);
                                    }
                                  },
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

  Widget _buildFavoritesList(BuildContext context, BookListViewModel viewModel) {
    int itemsPerRow = 5;
    int rowCount = (viewModel.favorites.length / itemsPerRow).ceil();

    return viewModel.favorites.isEmpty
        ? Center(child: Text('No favorite books'))
        : ListView.builder(
            itemCount: rowCount,
            itemBuilder: (context, rowIndex) {
              final rowBooks = viewModel.favorites.skip(rowIndex * itemsPerRow).take(itemsPerRow).toList();

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
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    book.author,
                                    style: TextStyle(fontSize: 14, color: Colors.grey),
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
