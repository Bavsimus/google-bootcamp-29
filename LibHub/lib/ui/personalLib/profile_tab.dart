import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'personal_library_viewmodel.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PersonalLibraryViewModel>.reactive(
      viewModelBuilder: () => PersonalLibraryViewModel(),
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50.0, // Profil fotoğrafının boyutu
                backgroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/82062115?v=4', // Profil fotoğrafı URL'si
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'John Doe', // Kullanıcının ismi
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'john.doe@example.com', // Kullanıcının e-posta adresi
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
              // En çok okunan kategori widget'ı, şu an için sabit bir değer gösteriyoruz
              Text(
                'Fiction', // Burayı gerçek en çok okunan kategoriyle güncelleyin
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
