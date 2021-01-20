import 'dart:core';
import 'package:flutter/material.dart';
import 'package:gknow/noteFirestore.dart';
import 'package:gknow/addNote.dart';
import 'login.dart';
import 'myDrawer.dart';

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  List userNotesList = [];

  @override
  void initState() {
    super.initState();
    fetchNotesFirestore();
  }

  fetchNotesFirestore() async {
    dynamic resultant = await NoteFirestore().getNotes(Login.email);

    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        userNotesList = resultant;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var deviceOrientation = MediaQuery.of(context).orientation;
    var screenSize = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text("Notes"),
        backgroundColor: Colors.black,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AddNote("Add Note", "", "", "", "Notes")));
        },
        label: Text('Add'),
        icon: Icon(Icons.notes),
        backgroundColor: Colors.black,
      ),
      body: _buildLayout(screenSize, deviceOrientation),
    );
  }

  Widget _repositoriesPart(double screenSize, Orientation deviceOrientation) {
    return Expanded(
      child: Column(
        children: [
          _notesList(screenSize),
        ],
      ),
    );
  }

  Widget _notesList(double screenSize) {
    return Expanded(
      child: ListView.builder(
          itemCount: userNotesList.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                leading: Icon(Icons.message_sharp),
                title: Text(userNotesList[index]['title']),
                subtitle: Text(userNotesList[index]['context']),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.amber,
                ),
                onLongPress: () async {
                  await NoteFirestore().deleteNote(userNotesList[index]['id']);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Notes()));
                },
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddNote(
                              "Update Note",
                              userNotesList[index]['title'],
                              userNotesList[index]['context'],
                              userNotesList[index]['id'],
                              "Notes")));
                },
              ),
            );
          }),
    );
  }

  Widget _buildLayout(double screenSize, Orientation deviceOrientation) {
    return Container(
      child: Column(
        children: [
          _repositoriesPart(screenSize, deviceOrientation),
        ],
      ),
    );
  }
}
