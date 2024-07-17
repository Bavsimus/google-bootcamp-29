import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'personal_library_viewmodel.dart';

class PersonalLibraryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PersonalLibraryViewModel>.reactive(
      viewModelBuilder: () => PersonalLibraryViewModel(),
      builder: (context, model, child) => DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: AppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TabBar(
                    indicatorColor: Color.fromARGB(
                        255, 33, 116, 93), // Tab göstergesi rengi
                    labelColor: Color.fromARGB(
                        255, 33, 116, 93), // Seçili tab yazı rengi
                    tabs: [
                      Tab(text: 'LibHub'),
                      Tab(text: 'Profile'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      onChanged: model.updateSearchQuery,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  Expanded(
                    child: BooksGridView(books: model.books),
                  ),
                ],
              ),
              Center(child: Text('This page is intentionally left blank')),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              model.addBook(
                  'New Book', 'New Writer', 'https://example.com/new_book.jpg');
            },
            tooltip: 'Add book',
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

class BooksGridView extends StatelessWidget {
  final List<Book> books;

  BooksGridView({required this.books});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: GridView.builder(
        itemCount: books.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 0.5,
        ),
        itemBuilder: (context, index) {
          final book = books[index];
          Color boxColor = index % 2 == 0
              ? Colors.blueGrey
              : Color.fromARGB(255, 33, 116, 93);

          return Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0),
              color: boxColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: Image.network(
                      book.coverUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  book.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2.0),
                Text(
                  book.author,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
