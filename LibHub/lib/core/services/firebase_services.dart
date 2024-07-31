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

  Future<String?> login(BuildContext context, email, String password) async {
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
        case "user-not-found" || "wrong-password":
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
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());

      User? user = userCredential.user;

      if (user != null) {
        await user.updateDisplayName(userName);
        await user.reload(); // Bilgileri güncellemek için.
        user = FirebaseAuth.instance.currentUser;
        print("User's Display Name: ${user?.displayName}");
      } else {
        print("User creation failed.");
      }

      String uid = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'userName': userName,
        'email': email,
        'city': city,
      });
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
          String uid = userCredential.user!.uid;

          await FirebaseFirestore.instance.collection('users').doc(uid).set({
            'userName': displayName,
            'email': email,
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

  void saveBookToPersonalLib(
      {required String bookName, required String userEmail}) async {
    try {
      final userQuerySnapshot = await firebaseFirestore
          .collection("users")
          .where("email", isEqualTo: userEmail)
          .get();

      if (userQuerySnapshot.docs.isNotEmpty) {
        // Assuming there is only one document for the given email
        DocumentSnapshot userDoc = userQuerySnapshot.docs.first;

        // Access the 'advices' sub-collection and add a new document
        userDoc.reference.collection("favoriteBooks").add({
          "bookName": bookName,
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

  Future<String> getUserName() async {
    String email = getCurrentUser().email!;

    try {
      final userQuerySnapshot = await firebaseFirestore
          .collection("users")
          .where("email", isEqualTo: email)
          .get();

      if (userQuerySnapshot.docs.isNotEmpty) {
        DocumentSnapshot userDoc = userQuerySnapshot.docs.first;
        return userDoc.get("userName");
      } else {
        return "İsimsiz Kullanıcı";
      }
    } catch (e) {
      log("Error getting user name: $e");
      return "İsimsiz Kullanıcı";
    }
  }
}
