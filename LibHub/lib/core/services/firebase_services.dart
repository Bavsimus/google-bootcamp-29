import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;

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

  Future<String?> signIn(
      {required BuildContext context,
      required String userName,
      required String email,
      required String password}) async {
    String? res;
    try {
      final result = await firebaseAuth.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());
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


Future<void> googleSignIn() async {
  try {
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    // Kullanıcıyı kimlik doğrulama sağlayıcısı ile oturum açtırır
    UserCredential userCredential = await FirebaseAuth.instance.signInWithProvider(googleProvider);

    // Kullanıcıyı alır
    User? user = userCredential.user;

    // Kullanıcıdan gerekli bilgileri alır
    String? email = user?.email;
    String? displayName = user?.displayName;
    


    log("Kullanıcı adı: $displayName, E-posta: $email");
  } catch (e) {
    log("googleSignIn error -> $e");
  }
}


}
