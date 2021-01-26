import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gknow/deleteUser.dart';
import 'package:gknow/licences.dart';
import 'package:gknow/login.dart';
import 'package:gknow/miss.dart';
import 'package:gknow/myDrawer.dart';
import 'package:gknow/profile.dart';
import 'package:gknow/termsOfServices.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import 'authenticationService.dart';
import 'changeUsername.dart';
import 'backgroundTask.dart';
import 'main.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Future<Widget> _onSelectNotification(String payload) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Miss(),
      ),
    );
  }

  SharedPreferences prefs;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _loadInitialization();
  }

  _loadInitialization() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _isInitialized = (prefs.getBool('isInitialized') ?? false);
    });
  }

  _makeInitialized() {
    setState(() {
      _isInitialized = true;
      prefs.setBool('isInitialized', _isInitialized);
    });
  }


  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.black,
      ),
      body: _buildLayout(context, screenSize),
    );
  }

  Widget _buildLayout(BuildContext context, double screenSize) {
    return Container(
      child: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(screenSize / 20),
                  child: Text(
                    'Account',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.amberAccent),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text('Sign Out'),
            subtitle: Text(Profile.username),
            leading: Icon(
              Icons.subdirectory_arrow_left_sharp,
              color: Colors.black,
            ),
            onTap: () async {
              await AuthenticationService().signOut();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => MyApp()));
            },
          ),
          ListTile(
            title: Text('Change Profile Username'),
            subtitle: Text('For GitHub account that shows in the  profile'),
            leading: Icon(
              Icons.track_changes_sharp,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ChangeUsername()));
            },
          ),
          ListTile(
            title: Text('Change G-Know Password'),
            subtitle: Text('When you click this you will get an reset e-mail'),
            leading: Icon(
              Icons.lock,
              color: Colors.black,
            ),
            onTap: () {
              AuthenticationService().changePassword(Login.email);
            },
          ),
          Divider(
            height: 20,
            thickness: 2,
          ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(screenSize / 20),
                  child: Text(
                    'Notifications',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.amberAccent),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text('Subscribe Notifications'),
            subtitle: Text('Initialize notification settings'),
            leading: Icon(
              Icons.notification_important_outlined,
              color: Colors.black,
            ),
            onTap: () {
              _isInitialized = (prefs.getBool('isInitialized') ?? false);
              if (!_isInitialized) {
                var initializationSettingsAndroid =
                AndroidInitializationSettings('launch_background');
                var initializationSettingsIOs = IOSInitializationSettings();
                var initSetttings = InitializationSettings(
                  android: initializationSettingsAndroid,
                  iOS: initializationSettingsIOs,
                  macOS: null,
                );

                flutterLocalNotificationsPlugin.initialize(
                  initSetttings,
                  onSelectNotification: _onSelectNotification,
                );
                Workmanager.initialize(
                  callbackDispatcher,
                  isInDebugMode: false,
                );
                _makeInitialized();
                print("Notification settings were initialized successfully");
                final snackBar =
                SnackBar(content: Text("Notification settings were initialized successfully"));
                Scaffold.of(context).showSnackBar(snackBar);
              } else {
                print("Notification settings were already initialized");
                final snackBar =
                SnackBar(content: Text("Notification settings were already initialized"));
                Scaffold.of(context).showSnackBar(snackBar);
              }

            },
          ),
          ListTile(
            title: Text('Background Tasks'),
            subtitle: Text('Change your preferences about notifications'),
            leading: Icon(
              Icons.notifications_active,
              color: Colors.black,
            ),
            onTap: () {
              _isInitialized = (prefs.getBool('isInitialized') ?? false);
              if (_isInitialized) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => BackgroundTask()));
              } else {
                print("Notification settings not initialized");
                final snackBar =
                SnackBar(content: Text("Please, initialize notification settings from up"));
                Scaffold.of(context).showSnackBar(snackBar);
              }

            },
          ),
          ListTile(
            title: Text('Miss Page'),
            subtitle: Text('To show this page when notification clicked' ),
            leading: Icon(
              Icons.all_inclusive_sharp,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Miss()));
            },
          ),
          Divider(
            height: 20,
            thickness: 2,
          ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(screenSize / 20),
                  child: Text(
                    'Misc',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.amberAccent),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text('Terms of Service'),
            // subtitle: Text('From your favourite user\'s ' ),
            leading: Icon(
              Icons.description,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => TermsOfServices()));
            },
          ),
          ListTile(
            title: Text('Open source licenses'),
            // subtitle: Text('From your favourite user\'s ' ),
            leading: Icon(
              Icons.collections_bookmark,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => OpenSourceLicences()));
            },
          ),
          Divider(
            height: 20,
            thickness: 2,
          ),
          ListTile(
            title: Text('Delete Account'),
            // subtitle: Text('From your favourite user\'s ' ),
            leading: Icon(
              Icons.delete_forever,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Deleteuser()));
            },
          ),
          Divider(
            height: 20,
            thickness: 2,
          ),
        ],
      )),
    );
  }
}

