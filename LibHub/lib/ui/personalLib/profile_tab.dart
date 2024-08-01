import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

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

  final List<String> _categories = [
    'All',
    'Fiction',
    'Non-Fiction',
    'Science',
    'Fantasy',
  ];

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
                color: Colors.teal, // Güncellenmiş renk
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
                  onPressed: () {
                    setState(() {
                      _isEditingBooks = !_isEditingBooks;
                    });
                  },
                ),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height *
                  0.15 *
                  1.44, // %44 büyütme
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: _isEditingBooks
                        ? () => _showEmptyDialog(context)
                        : null,
                    child: Container(
                      width: MediaQuery.of(context).size.width *
                          0.18 *
                          1.44, // %44 büyütme
                      height: MediaQuery.of(context).size.height *
                          0.15 *
                          1.44, // %44 büyütme
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
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

  void _showEmptyDialog(BuildContext context) {
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
                SizedBox(height: 8),
                Text(
                  "Burada searchbar olacak ve aradığı kitap okuduğu kitaplar arasında varsa seçebilecek.",
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
