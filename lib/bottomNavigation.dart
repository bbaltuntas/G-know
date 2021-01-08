import 'package:flutter/material.dart';
import 'package:gknow/main.dart';
import 'package:gknow/myDrawer.dart';
import 'package:gknow/notification.dart';
import 'profile.dart';
import 'search.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = MyDrawer.selectionIndex;
  // static const TextStyle optionStyle =  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  List<Widget> _widgetOptions = <Widget>[
    Profile(),
    Search(),
    NotificationPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: MyApp.isLogin ? MyDrawer() : null,
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: MyApp.isLogin
            ? BottomNavigationBar(
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle_rounded),
                    label: 'Profile',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: 'Search',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.message_sharp),
                    label: 'Notification',
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.amber[800],
                onTap: _onItemTapped,
              )
            : null,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
