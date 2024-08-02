import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UsersFromSameCityPage extends StatefulWidget {
  @override
  _UsersFromSameCityPageState createState() => _UsersFromSameCityPageState();
}

class _UsersFromSameCityPageState extends State<UsersFromSameCityPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String userCity = '';

  @override
  void initState() {
    super.initState();
    _getCurrentUserCity();
  }

  Future<void> _getCurrentUserCity() async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();
      setState(() {
        userCity = userDoc['city'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(
              left: 16.0), // İkonun soluna padding ekleyin
          child: Icon(
            Icons
                .change_circle_outlined, // Burada istediğiniz ikonu kullanabilirsiniz
            color: Colors.blueAccent,
          ),
        ),
        title: Text(
          'Trade Your Book',
          style: TextStyle(
            color: Colors.blueAccent,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        ),
      ),
      body: userCity.isEmpty
          ? Center(child: CircularProgressIndicator())
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where('city', isEqualTo: userCity)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                var users = snapshot.data?.docs;

                return ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  itemCount: users?.length,
                  itemBuilder: (context, index) {
                    var user = users?[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      elevation: 5,
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16.0),
                        title: Text(
                          user?['userName'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(user?['city']),
                        trailing: ElevatedButton(
                          onPressed: () {
                            // Butona tıklanınca yapılacak işlemler
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors
                                .blueAccent, // Butonun arka plan rengini mavi yapar
                          ),
                          child: Text('Trade',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
