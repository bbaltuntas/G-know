import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gknow/myDrawer.dart';
import 'backgroundTask.dart';
import 'bottomNavigation.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static bool isLogin = false;
  static List adviceList = [];

  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  @override


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: AuthenticationWrapper(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser != null) {
      MyApp.isLogin = true;
      MyDrawer.selectionIndex = 0;
      return BottomNavigation();
    }

    return Login();
  }
}

