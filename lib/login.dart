import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gknow/authenticationService.dart';
import 'package:gknow/main.dart';
import 'package:gknow/register.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  static String email;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailControl = new TextEditingController();
  TextEditingController passwordControl = new TextEditingController();
  bool flag = false;

  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  @override
  Widget build(BuildContext context) {
    var deviceOrientation = MediaQuery.of(context).orientation;
    var screenSize = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text('Login')),
        backgroundColor: Colors.black,
      ),
      body: _connectionStatus == "ConnectivityResult.none"
          ? _noConnection(screenSize, deviceOrientation)
          : _buildLayout(screenSize, deviceOrientation),
    );
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }

  Widget _noConnection(double screenSize, Orientation deviceOrientation) {
    return Column(
      children: [
        SizedBox(height: screenSize / 5),
        Container(
          width: screenSize / 2,
          height: screenSize / 2,
          child: Image.asset(
            'assets/images/profile.png',
            width:
                deviceOrientation == Orientation.portrait ? screenSize / 2 : 0,
          ),
        ),
        SizedBox(height: screenSize / 15),
        Text(
          "Please be sure that you have an internet connection.",
          style: TextStyle(
            fontSize: 18,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        )
      ],
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: screenSize / 2,
                    height: screenSize / 8,
                    child: FlatButton(
                      color: Colors.amberAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () async {
                        var hasError = await AuthenticationService().signIn(
                            email: emailControl.text.trim(),
                            password: passwordControl.text.trim());
                        Login.email = emailControl.text.trim();

                        if (hasError) {
                          final snackBar = SnackBar(
                              content: Text(
                                  "Username or/and Password is incorrect!"));
                          Scaffold.of(context).showSnackBar(snackBar);
                        } else {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => MyApp()));
                        }
                      },
                      child: Text('Login'),
                    ),
                  ),
                  SizedBox(width: screenSize / 12),
                  Container(
                    width: screenSize / 4,
                    height: screenSize / 8,
                    child: FlatButton(
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register()));
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
