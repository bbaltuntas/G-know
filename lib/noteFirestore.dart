import 'package:cloud_firestore/cloud_firestore.dart';

class NoteFirestore {

  CollectionReference notes = FirebaseFirestore.instance.collection('notes');

  Future<void> addNote(String email, String title, String context) async {
    return await notes
        .add({
      'email': email, // John Doe
      'title': title, // Stokes and Sons
      'context': context,
      'id': "",
    })
        .then((value) {
          notes.doc(value.id).update({'id': value.id});
          print("Note Added");
        })
        .catchError((error) => print("Failed to add note: $error"));
  }

  Future<void> updateNote(String noteID, String newTitle, String newContext) async {
    return await notes.doc(noteID).update({"title": newTitle, 'context': newContext})
        .then((value) => print("Note Updated"))
        .catchError((error) => print("Failed to update note: $error"));
  }

  Future<void> deleteNote(String noteID) async {
    return await notes.doc(noteID).delete()
        .then((value) => print("Note Deleted"))
        .catchError((error) => print("Failed to delete note: $error"));
  }

  Future getNotes(String email) async {
    List notesList = [];

    try {
      await notes.where('email', isEqualTo: email).get()
          .then((value) {
        print("Notes Found");
        value.docs.forEach((element) {
          notesList.add(element.data());
        });
      });
      return notesList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future deleteNotes(String email) async {
    List notesList = [];

    try {
      await notes.where('email', isEqualTo: email).get()
          .then((value) {
        value.docs.forEach((element) {
          print("Note Deleted $element");
          deleteNote(element.id);
        });
      });
      return notesList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}