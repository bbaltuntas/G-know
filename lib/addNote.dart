import 'package:flutter/material.dart';
import 'package:gknow/bottomNavigation.dart';
import 'package:gknow/noteFirestore.dart';
import 'package:gknow/notes.dart';
import 'package:gknow/profile.dart';
import 'login.dart';

class AddNote extends StatefulWidget {
  String addUpdateNote;
  String titleNote;
  String contextNote;
  String noteID;
  String noteProfile;

  AddNote(this.addUpdateNote, this.titleNote, this.contextNote, this.noteID,
      this.noteProfile);

  @override
  _AddNoteState createState() =>
      _AddNoteState(addUpdateNote, titleNote, contextNote, noteID, noteProfile);
}

class _AddNoteState extends State<AddNote> {
  TextEditingController titleControl = new TextEditingController();
  TextEditingController contextControl = new TextEditingController();

  String addUpdateNote;
  String titleNote;
  String contextNote;
  String noteID;
  String noteProfile;

  _AddNoteState(this.addUpdateNote, this.titleNote, this.contextNote,
      this.noteID, this.noteProfile);

  @override
  void initState() {
    super.initState();
    if (addUpdateNote != "Add Note") {
      titleControl.text = titleNote;
      contextControl.text = contextNote;
    }
  }

  @override
  Widget build(BuildContext context) {
    var deviceOrientation = MediaQuery.of(context).orientation;
    var screenSize = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(addUpdateNote)),
        backgroundColor: Colors.black,
      ),
      body: _buildLayout(screenSize, deviceOrientation),
    );
  }

  Widget _buildLayout(double screenSize, Orientation deviceOrientation) {
    return ListView(
      children: [
        Container(
          padding: EdgeInsets.all(screenSize / 34),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenSize / 30),
              TextField(
                controller: titleControl,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.amberAccent),
                  ),
                  border: OutlineInputBorder(),
                  labelText: 'Enter your title',
                  labelStyle: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: screenSize / 40),
              Container(
                child: TextField(
                  controller: contextControl,
                  minLines: 10,
                  maxLines: 15,
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: 'Write your context here',
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.amberAccent),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenSize / 40),
              Container(
                width: screenSize,
                height: screenSize / 8,
                child: FlatButton(
                  color: Colors.amberAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () async {
                    addUpdateNote == "Add Note"
                        ? await NoteFirestore().addNote(
                            Login.email,
                            titleControl.text.trim(),
                            contextControl.text.trim())
                        : await NoteFirestore().updateNote(
                            noteID,
                            titleControl.text.trim(),
                            contextControl.text.trim());
                    Profile.isTrue = true;

                    noteProfile == "Profile"
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomNavigation()))
                        : Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Notes()));
                  },
                  child: Text(addUpdateNote),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
