import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileTab extends StatefulWidget {
  ProfileTab({super.key});

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  bool _isEditingBooks = false;
  bool _isEditingCategory = false;

  String _selectedCategory = 'All';
  final user = FirebaseAuth.instance.currentUser!;
  List<DocumentSnapshot> _favoriteBooks = [];

  final List<String> _categories = [
    'All',
    'Fiction',
    'Non-Fiction',
    'Science',
    'Fantasy',
  ];

  @override
  void initState() {
    super.initState();
    _fetchFavoriteBooks();
  }

  Future<void> _fetchFavoriteBooks() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('favourites')
        .get();
    setState(() {
      _favoriteBooks = snapshot.docs;
    });
  }

  void _toggleEditingBooks() {
    setState(() {
      _isEditingBooks = !_isEditingBooks;
    });
  }

  Future<void> _showRemoveDialog(DocumentSnapshot bookDoc) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 16,
              contentPadding: EdgeInsets.all(16),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      bookDoc['bookImage'],
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    bookDoc['bookName'],
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    bookDoc['bookAuthor'],
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Are you sure you want to remove this book from your favorites?",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: StadiumBorder(),
                        ),
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(user.uid)
                              .collection('favourites')
                              .doc(bookDoc.id)
                              .delete();
                          Navigator.of(context).pop();
                          _fetchFavoriteBooks();
                        },
                        child: Text(
                          "Remove",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(width: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          shape: StadiumBorder(),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50.0,
              backgroundImage: NetworkImage(
                'https://avatars.githubusercontent.com/u/82062115?v=4',
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              user.displayName ?? 'İsimsiz Kullanıcı',
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              user.email!,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Favorite Top 5 Books',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    _isEditingBooks ? Icons.check : Icons.edit,
                    color: Colors.teal,
                  ),
                  onPressed: _toggleEditingBooks,
                ),
              ],
            ),
            Container(
              height:
                  MediaQuery.of(context).size.height * 0.5, // Updated height
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _favoriteBooks.length,
                itemBuilder: (context, index) {
                  var book =
                      _favoriteBooks[index].data() as Map<String, dynamic>;
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    margin: EdgeInsets.all(8),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      height: MediaQuery.of(context).size.height *
                          0.45, // Updated height
                      child: GestureDetector(
                        onTap: () {
                          if (_isEditingBooks) {
                            _showRemoveDialog(_favoriteBooks[index]);
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  book['bookImage'],
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                book['bookName'] ?? 'Kitap Adı Yok',
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
                                  book['bookAuthor'] ?? 'Yazar Bilgisi Yok',
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
                },
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Most Read Category',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    _isEditingCategory ? Icons.check : Icons.edit,
                    color: Colors.teal,
                  ),
                  onPressed: () {
                    setState(() {
                      _isEditingCategory = !_isEditingCategory;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            _isEditingCategory
                ? DropdownButton<String>(
                    value: _selectedCategory,
                    icon: Icon(Icons.arrow_drop_down, color: Colors.teal),
                    elevation: 16,
                    style: TextStyle(color: Colors.teal, fontSize: 16.0),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCategory = newValue!;
                      });
                    },
                    items: _categories
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
                : Container(),
            const SizedBox(height: 8.0),
            !_isEditingCategory
                ? Container(
                    height: 48.0,
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Center(
                        child: Text(
                          _selectedCategory == 'All'
                              ? 'No category data available'
                              : '$_selectedCategory',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.teal[500],
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
