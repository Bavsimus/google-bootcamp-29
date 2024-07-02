import 'package:flutter/material.dart';

//
class AddBySearchingScreen extends StatefulWidget {
  const AddBySearchingScreen({Key? key}) : super(key: key);

  @override
  _AddBySearchingScreenState createState() => _AddBySearchingScreenState();
}

class _AddBySearchingScreenState extends State<AddBySearchingScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add by Searching'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search books...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Üç sütunlu bir grid
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: 10, // Örnek olarak 10 kitap
              itemBuilder: (context, index) {
                // Burada kitap resimleri veya placeholder'ları yerleştirin
                return Container(
                  color: Colors.grey[200],
                  child: Center(
                    child: Text('Book $index'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
