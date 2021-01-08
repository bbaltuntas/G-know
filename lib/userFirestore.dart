import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gknow/profile.dart';

class UserFirestore {

  CollectionReference usernames = FirebaseFirestore.instance.collection('usernames');

  Future<void> addUsername(String email, String username) {
    return usernames
        .add({
      'email': email, // John Doe
      'username': username, // Stokes and Sons
    })
        .then((value) => print("Username Added"))
        .catchError((error) => print("Failed to add username: $error"));
  }

  Future<void> updateUsername(String usernameID, String newUsername) {
    return usernames.doc(usernameID).update({"username": newUsername})
        .then((value) => print("Username Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> deleteUsername(String usernameID) {
    return usernames.doc(usernameID).delete()
        .then((value) => print("Username deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  Future<void> getUsername(String email) {
    return usernames.where('email', isEqualTo: email).get()
        .then((value) {
          print("Username Found");
          Profile.username = value.docs[0].get('username').toString();
          Profile.usernameID = value.docs[0].id;
        })
        .catchError((error) => print("Failed to found user: $error"));
  }

}
