import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'personal_library_viewmodel.dart';

class PersonalLibraryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PersonalLibraryViewModel>.reactive(
      viewModelBuilder: () => PersonalLibraryViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 8.0),
              decoration: BoxDecoration(
                color: Colors.blue, // Yazının arkaplan rengi
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0), // Alt sol köşe
                  bottomRight: Radius.circular(20.0), // Alt sağ köşe
                ),
              ),
              child: Row(
                children: [
                  Text(
                    'Your LibHub',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black, // Yazı rengi
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Container(
                      height: 2.0,
                      color: Colors.black,
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.grey[200], // Duman rengi arka plan
                padding: EdgeInsets.all(8.0),
                child: GridView.builder(
                  itemCount: model.books.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Her sırada 3 kitap
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 0.5, // Yükseklik ve genişlik oranı
                  ),
                  itemBuilder: (context, index) {
                    final book = model.books[index];
                    Color boxColor = index % 2 == 0 ? Colors.blue : Colors.red;

                    return Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                        color: boxColor, // Mavi veya kırmızı arka plan
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
                              color: Colors.white, // Yazı rengi
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
                              color: Colors.white, // Yazı rengi
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
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
    );
  }
}
