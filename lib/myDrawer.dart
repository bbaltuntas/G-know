import 'package:flutter/material.dart';
import 'package:gknow/bottomNavigation.dart';
import 'package:gknow/favoriteUsers.dart';
import 'package:gknow/notes.dart';
import 'package:gknow/profile.dart';
import 'package:gknow/settings.dart';

import 'history.dart';

class MyDrawer extends StatefulWidget {
  static int selectionIndex = 0;

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    var deviceOrientation = MediaQuery.of(context).orientation;
    var screenSize = MediaQuery.of(context).size.width;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: deviceOrientation == Orientation.portrait
                ? (screenSize > 720
                    ? (screenSize * 2.54) / 6.5
                    : (screenSize * 2.54) / 4.5)
                : 45,
            child: DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      'assets/images/profile.png',
                      width: deviceOrientation == Orientation.portrait
                          ? screenSize / 2
                          : 0,
                    ),
                  ),
                  SizedBox(
                    height: screenSize / 30,
                  ),
                  Text(
                    Profile.username,
                    style: TextStyle(color: Colors.black, fontSize: 30),
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.amberAccent,
              ),
            ),
          ),
          ListTile(
            title: Text('Profile'),
            leading: Icon(Icons.account_circle),
            onTap: () {
              MyDrawer.selectionIndex = 0;
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BottomNavigation()));
            },
          ),
          ListTile(
            title: Text('Search'),
            leading: Icon(Icons.search),
            onTap: () {
              MyDrawer.selectionIndex = 1;
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BottomNavigation()));
            },
          ),
          ListTile(
            title: Text('Advices'),
            leading: Icon(Icons.message_rounded),
            onTap: () {
              MyDrawer.selectionIndex = 2;
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BottomNavigation()));
            },
          ),
          ListTile(
            title: Text('Notes'),
            leading: Icon(Icons.notes),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Notes()));
            },
          ),
          ListTile(
            title: Text('Favorite Users'),
            leading: Icon(Icons.notifications_active),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FavoriteUsers()));
            },
          ),
          ListTile(
            title: Text('Search History'),
            leading: Icon(Icons.history),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => History()));
            },
          ),
          ListTile(
            title: Text('Settings'),
            leading: Icon(Icons.settings),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Settings()));
            },
          ),
        ],
      ),
    );
  }
}
