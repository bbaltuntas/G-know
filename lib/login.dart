import 'package:flutter/material.dart';
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
            SizedBox(height: screenSize / 35),
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
                      context.read<AuthenticationService>().signIn(
                        email: emailControl.text.trim(),
                        password: passwordControl.text.trim(),
                      );
                      Login.email = emailControl.text.trim();
                      UserFirestore().getUsername(emailControl.text.trim());
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomNavigation()));
                    },
                      child: Text('Login'),
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
                          MaterialPageRoute(builder: (context) => Register()));
                    },
                    child: Text('Register', style: TextStyle(color: Colors.white),),
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
