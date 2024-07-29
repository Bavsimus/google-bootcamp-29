import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'personal_library_viewmodel.dart';

class PersonalLibraryView extends StatelessWidget {
  const PersonalLibraryView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PersonalLibraryViewModel>.reactive(
      viewModelBuilder: () => PersonalLibraryViewModel(),
      onModelReady: (model) async {
        await model
            .initialize(); // ViewModel başlatıldığında Firestore'dan veri çek
      },
      builder: (context, model, child) => Scaffold(
        body: Column(
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
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: model.isBusy
                  ? Center(
                      child:
                          CircularProgressIndicator()) // Veriler yüklenirken gösterilecek
                  : BooksGridView(books: model.filteredBooks),
            ),
          ],
        ),
        // Bu kısmı yorum haline getirdik
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     model.addBook(
        //         'New Book', 'New Author', 'https://example.com/new_book.jpg');
        //   },
        //   tooltip: 'Add book',
        //   child: const Icon(Icons.add),
        // ),
      ),
    );
  }
}

class BooksGridView extends StatelessWidget {
  final List<Book> books;

  const BooksGridView({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        itemCount: books.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 0.5,
        ),
        itemBuilder: (context, index) {
          final book = books[index];
          Color boxColor = index % 2 == 0
              ? Colors.blueGrey
              : const Color.fromARGB(255, 33, 116, 93);

          return Container(
            padding: const EdgeInsets.all(8.0),
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
                  style: const TextStyle(
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
                  style: const TextStyle(
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
