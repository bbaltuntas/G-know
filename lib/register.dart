import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gknow/login.dart';
import 'package:gknow/userFirestore.dart';
import 'package:provider/provider.dart';
import 'authenticationService.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailControl = new TextEditingController();
  TextEditingController passwordControl = new TextEditingController();
  TextEditingController usernameControl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var deviceOrientation = MediaQuery.of(context).orientation;
    var screenSize = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text('Register')),
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
            Image.asset(
              'assets/images/profile.png',
              width: deviceOrientation == Orientation.portrait
                  ? screenSize / 2
                  : 0,
            ),
            SizedBox(height: screenSize / 25),
            TextField(
              controller: emailControl,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.amberAccent),
                ),
                border: OutlineInputBorder(),
                labelText: 'e-mail',
                labelStyle: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: screenSize / 40),
            TextField(
              obscureText: true,
              controller: passwordControl,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.amberAccent),
                ),
                border: OutlineInputBorder(),
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: screenSize / 40),
            TextField(
              // obscureText: true,
              controller: usernameControl,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.amberAccent),
                ),
                border: OutlineInputBorder(),
                labelText: 'GitHub Username',
                labelStyle: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: screenSize / 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: screenSize/2,
                  height: screenSize/8,
                  child: FlatButton(
                    color: Colors.amberAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onPressed: () {
                      context.read<AuthenticationService>().signUp(
                        email: emailControl.text.trim(),
                        password: passwordControl.text.trim(),
                      );
                      UserFirestore().addUsername(emailControl.text.trim(), usernameControl.text.trim());
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Login()));
                    },
                    child: Text('Register'),
                  ),
                ),
                SizedBox(width: screenSize / 12),
                Container(
                  width: screenSize/4,
                  height: screenSize/8,
                  child: FlatButton(
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Text('Login', style: TextStyle(color: Colors.white),),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
