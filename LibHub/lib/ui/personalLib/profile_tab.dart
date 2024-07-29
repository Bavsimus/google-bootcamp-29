import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'personal_library_viewmodel.dart';

class ProfileTab extends StatelessWidget {
  ProfileTab({super.key});
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PersonalLibraryViewModel>.reactive(
      viewModelBuilder: () => PersonalLibraryViewModel(),
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50.0, // Profil fotoğrafının boyutu
                backgroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/82062115?v=4', // Profil fotoğrafı URL'si
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                user.displayName ?? 'İsimsiz Kullanıcı',
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                user.email!, // Kullanıcının e-posta adresi
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Top 5 Favorite Books',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              ...model.favoriteBooks.map((book) => Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: Image.network(
                        book.coverUrl,
                        width: 50,
                        height: 75,
                        fit: BoxFit.cover,
                      ),
                      title: Text(book.title),
                      subtitle: Text(book.author),
                    ),
                  )),
              const SizedBox(height: 16.0),
              const Text(
                'Most Read Category',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                model.mostReadCategory, // En çok okunan kategori
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
