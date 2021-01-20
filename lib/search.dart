import 'package:flutter/material.dart';
import 'package:gknow/DbHelperHistory.dart';
import 'package:gknow/searchProfile.dart';
import 'myDrawer.dart';
import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';

class Search extends StatefulWidget {
  static String username;

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  DbHelperHistory _dbHelperHistory;

  TextEditingController searchControl = new TextEditingController();

  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _dbHelperHistory = DbHelperHistory();
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
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Search"),
      ),
      body: _connectionStatus == "ConnectivityResult.none"
          ? _noConnection(screenSize, deviceOrientation)
          : _buildLayout(screenSize),
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

  Widget _buildLayout(double screenSize) {
    return ListView(
      children: [
        Container(
          child: Padding(
            padding: EdgeInsets.all(screenSize / 50),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    cursorColor: Colors.amber,
                    //obscureText: true,
                    controller: searchControl,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amberAccent),
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'Enter username',
                        labelStyle: TextStyle(color: Colors.grey)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: screenSize,
                    height: screenSize / 8,
                    child: FlatButton(
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {
                        setState(() {});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SearchProfile(searchControl.text)));
                      },
                      child: Icon(
                        Icons.search,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
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
}
