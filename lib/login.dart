import 'package:flutter/material.dart';
import 'package:gknow/profile.dart';
import 'package:gknow/register.dart';
import 'package:gknow/userFirestore.dart';
import 'package:provider/provider.dart';
import 'authenticationService.dart';
import 'bottomNavigation.dart';

class Login extends StatefulWidget {
  static String email;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailControl = new TextEditingController();
  TextEditingController passwordControl = new TextEditingController();

  void alert(BuildContext context, String mesaj) {
    var alert = AlertDialog(
      title: Text("Wrong!"),
      content: (Text(mesaj)),
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  @override
  Widget build(BuildContext context) {
    var deviceOrientation = MediaQuery.of(context).orientation;
    var screenSize = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text('Login')),
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
            Image.asset(
              'assets/images/profile.png',
              width: deviceOrientation == Orientation.portrait
                  ? screenSize / 2
                  : 0,
            ),
            SizedBox(height: screenSize / 30),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  color: Colors.amberAccent,
                  onPressed: () {
                    context.read<AuthenticationService>().signIn(
                      email: emailControl.text.trim(),
                      password: passwordControl.text.trim(),
                    );
                    UserFirestore().getUsername(emailControl.text.trim());
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BottomNavigation()));
                  },
                  child: Text('Login'),
                ),
                SizedBox(width: screenSize / 12),
                FlatButton(
                  color: Colors.amberAccent,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Register()));
                  },
                  child: Text('Register'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
