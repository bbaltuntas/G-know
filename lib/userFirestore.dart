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

  Future<void> changeUsername(String newUsername) {
    return usernames.doc(Profile.usernameID).update({"username": newUsername})
        .then((value) => print("Username Changed"))
        .catchError((error) => print("Failed to add user: $error"));
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
