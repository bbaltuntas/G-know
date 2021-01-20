import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  signOut() async {
    await _auth.signOut();
  }

  delete() async {
    await _auth.currentUser.delete();
  }

  changePassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return "Password Changed";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<bool> signIn({String email, String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return false;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return true;
    }
  }

  Future<bool> signUp({String email, String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print("Signed up");
      return false;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return true;
    }
  }
}
