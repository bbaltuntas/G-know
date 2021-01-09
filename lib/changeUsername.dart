import 'package:flutter/material.dart';
import 'package:gknow/bottomNavigation.dart';
import 'package:gknow/profile.dart';
import 'package:gknow/userFirestore.dart';

class ChangeUsername extends StatefulWidget {

  @override
  _ChangeUsernameState createState() => _ChangeUsernameState();
}

class _ChangeUsernameState extends State<ChangeUsername> {
  TextEditingController newUsernameControl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var deviceOrientation = MediaQuery.of(context).orientation;
    var screenSize = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Center(child: Text('Change Username')),
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
            SizedBox(height: screenSize / 40),
            TextField(
              controller: newUsernameControl,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.amberAccent),
                ),
                border: OutlineInputBorder(),
                labelText: 'Enter New Username',
                labelStyle: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: screenSize / 40),
            Container(
              width: screenSize,
              height: screenSize/8,
              child: FlatButton(
                color: Colors.amberAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () async {
                  UserFirestore().updateUsername(Profile.usernameID, newUsernameControl.text.trim());
                  Profile.username = newUsernameControl.text.trim();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => BottomNavigation()));
                },
                child: Text('Change Username'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
