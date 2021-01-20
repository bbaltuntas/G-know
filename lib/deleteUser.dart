import 'package:flutter/material.dart';
import 'package:gknow/noteFirestore.dart';
import 'package:gknow/profile.dart';
import 'package:gknow/userFirestore.dart';
import 'authenticationService.dart';
import 'login.dart';

class Deleteuser extends StatefulWidget {
  @override
  _DeleteuserState createState() => _DeleteuserState();
}

class _DeleteuserState extends State<Deleteuser> {
  TextEditingController deleteControl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var deviceOrientation = MediaQuery.of(context).orientation;
    var screenSize = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Delete User")),
        backgroundColor: Colors.black,
      ),
      body: _buildLayout(screenSize, deviceOrientation),
    );
  }

  Widget _buildLayout(double screenSize, Orientation deviceOrientation) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(screenSize / 34),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: screenSize / 30),
            Text(
              "After you click the delete button, your notes, "
              "favorite users and G-Know membership information will be deleted irreversibly. "
              "If you are still determined to delete your account, write \"acknowledged\" in the message box "
              "and click the \"delete\" button. ",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: screenSize / 40),
            TextField(
              controller: deleteControl,
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
                labelText: 'acknowledged',
                labelStyle: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: screenSize / 40),
            Container(
              width: screenSize,
              height: screenSize / 8,
              child: FlatButton(
                color: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {
                  if (deleteControl.text.trim() == "acknowledged") {
                    UserFirestore().deleteUsername(Profile.usernameID);
                    NoteFirestore().deleteNotes(Login.email);
                    AuthenticationService().delete();
                    final snackBar = SnackBar(
                        content: Text("Account was deleted successfully!"));
                    Scaffold.of(context).showSnackBar(snackBar);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  } else {
                    print("Wrong keyword entered!");
                    final snackBar =
                        SnackBar(content: Text("Wrong keyword entered!"));
                    Scaffold.of(context).showSnackBar(snackBar);
                  }
                },
                child: Text(
                  "Delete",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
