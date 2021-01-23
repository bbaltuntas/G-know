import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gknow/profile.dart';

class UserFirestore {
  CollectionReference usernames =
      FirebaseFirestore.instance.collection('usernames');

  addUsername({String email, String password, String username}) async {
    try {
      await usernames.add({
        'email': email,
        'password': password,
        'username': username,
      }).then((value) {
        usernames.doc(value.id).update({'usernameID': value.id});
      });
    } catch (e) {
      print('Warning!');
    }
  }

  updateUsername(String usernameID, String newUsername) async {
    try {
      await usernames.doc(usernameID).update({"username": newUsername});
    } catch (e) {
      print('Warning!');
    }
  }

  deleteUsername(String usernameID) async {
    try {
      await usernames.doc(usernameID).delete();
    } catch (e) {
      print('Warning!');
    }
  }

  getUsername(String email) async {
    return await usernames.where('email', isEqualTo: email).get().then((value) {
      print("Username Found");
      Profile.username = value.docs[0].get('username').toString();
      Profile.usernameID = value.docs[0].id;
    }).catchError((error) => print("Failed to found user: $error"));
  }
}
