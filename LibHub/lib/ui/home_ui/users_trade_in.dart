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
    User currentUser = _auth.currentUser!;
    if (currentUser != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).get();
      setState(() {
        userCity = userDoc['city'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trade your book'),
      ),
      body: userCity.isEmpty
          ? Center(child: CircularProgressIndicator())
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('users').where('city', isEqualTo: userCity).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                var users = snapshot.data?.docs;

                return ListView.builder(
                  itemCount: users?.length,
                  itemBuilder: (context, index) {
                    var user = users?[index];
                    return ListTile(
                      title: Text(user?['userName']),
                      subtitle: Text(user?['city']),
                      trailing: ElevatedButton(
                        onPressed: () {
                          // Butona tıklanınca yapılacak işlemler
                        },
                        child: Text('Trade'),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
