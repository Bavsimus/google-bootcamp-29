import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;

  User getCurrentUser() {
    return firebaseAuth.currentUser!;
  }

  Future<String?> login(
      BuildContext context, String email, String password) async {
    String? res;
    try {
      final result = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      log("result(login) -> $result");

      if (result.user != null) {
        res = "successful";
      } else {
        res = "failed";
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "user-not-found":
        case "wrong-password":
          res = "User is not found or invalid password";
          break;
        case "user-disabled":
          res = "User is disabled";
          break;
        case "invalid-credential":
          res = "Wrong credentials";
          log("invalid cr ->${e.code}");
          break;
        case "email-already-in-use":
          res = "There is already an account with this email";
          break;
        default:
          res = "An error occurred. Try again";
          break;
      }
    }
    return res;
  }

  Future<String?> signIn({
    required BuildContext context,
    required String userName,
    required String email,
    required String password,
    String? city,
  }) async {
    String? res;
    try {
      final result = await firebaseAuth.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());

      try {
        final resultData = await firebaseFirestore.collection("users").add({
          "userName": userName,
          "email": email,
          "city": city,
        });
      } catch (e) {
        log("catch 2 ->$e");
      }
    } on FirebaseAuthException catch (e) {
      log("catch 1 ->${e.code}");
      switch (e.code) {
        case "weak-password":
          res = "Don't use weak password";
          break;
        case "email-already-in-use":
          res = "There is already an account with this email";
          break;
        default:
          res = "An error occurred. Try again";
          break;
      }
    }
    return res;
  }

  Future<bool> googleSignIn() async {
    bool status = false;

    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return status;
      }

      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      User? user = userCredential.user;
      String? email = user?.email;
      String? displayName = user?.displayName;

      log("Kullanıcı adı: $displayName, E-posta: $email");

      if (email != null) {
        final querySnapshot = await firebaseFirestore
            .collection("users")
            .where("email", isEqualTo: email)
            .get();

        if (querySnapshot.docs.isEmpty) {
          await firebaseFirestore.collection("users").add({
            "email": email,
            "userName": displayName,
          });
          status = true;
        } else {
          log("Kullanıcı zaten mevcut");
          status = true;
        }
        return status;
      }
    } catch (e) {
      log("googleSignIn error -> $e");
      status = false;
      return status;
    }

    return status;
  }

  Future signInAnonymously() async {
    try {
      UserCredential userCredential = await firebaseAuth.signInAnonymously();
      User? user = userCredential.user;
      log("User id: ${user?.uid}");
    } catch (e) {
      log("signInAnonymously error -> $e");
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  // Kitap bilgilerini Firestore'a kaydeder
  Future<void> saveBookToPersonalLib({
    required String bookName,
    required String bookAuthor,
    required String bookImage,
    required String userEmail,
  }) async {
    try {
      final userQuerySnapshot = await firebaseFirestore
          .collection("users")
          .where("email", isEqualTo: userEmail)
          .get();

      if (userQuerySnapshot.docs.isNotEmpty) {
        // Kullanıcı bulunmuşsa, 'favoriteBooks' koleksiyonuna kitap ekle
        DocumentSnapshot userDoc = userQuerySnapshot.docs.first;

        await userDoc.reference.collection("favoriteBooks").add({
          "bookName": bookName,
          "bookAuthor": bookAuthor,
          "bookImage": bookImage,
          "date": DateTime.now(),
        });

        log("New book added successfully.");
      } else {
        log("User with the specified email not found.");
      }
    } catch (e) {
      log("Error adding book to lib: $e");
    }
  }
}
