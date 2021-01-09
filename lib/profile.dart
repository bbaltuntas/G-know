import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gknow/noteFirestore.dart';
import 'package:gknow/addNote.dart';
import 'package:http/http.dart' as http;
import 'package:gknow/reposApi.dart';
import 'User.dart';
import 'bottomNavigation.dart';
import 'login.dart';
import 'myDrawer.dart';

class Repos {
  final String name;

  Repos({this.name});

  factory Repos.fromJson(Map<String, dynamic> json) {
    return Repos(
      name: json['name'] as String,
    );
  }
}

class Profile extends StatefulWidget {
  static String username = "";
  static String usernameID = "";
  static var isTrue = false;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<User> getUser() async {
    var uri = ReposApi.url + "users/" + Profile.username + ReposApi.query;
    final response = await http.get(Uri.encodeFull(uri));

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Warning!');
    }
  }

  List<Repos> reposList = List<Repos>();
  List userNotesList = [];

  @override
  void initState() {
    super.initState();
    getReposFromApi();
    fetchNotesFirestore();
  }

  fetchNotesFirestore() async {
    dynamic resultant = await NoteFirestore().getNotes(Login.email);

    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        userNotesList = resultant;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var deviceOrientation = MediaQuery.of(context).orientation;
    var screenSize = MediaQuery.of(context).size.width;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Center(child: Text(Profile.username)),
          backgroundColor: Colors.black,
        ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddNote("Add Note", "", "", "", "Profile")));
        },
        label: Text('Add'),
        icon: Icon(Icons.notes),
        backgroundColor: Colors.black,
      ),
        body: FutureBuilder(
            future: getUser(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return _nullUserPart(screenSize);
              }
              if (snapshot.hasData) {
                return (deviceOrientation == Orientation.portrait
                    ? _buildVerticalLayout(
                        screenSize, deviceOrientation, snapshot)
                    : _buildHorizontalLayout(
                        screenSize, deviceOrientation, snapshot));
              } else {
                return Center(
                    child: CircularProgressIndicator(
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.black)));
              }
            }),
    );
  }

  Widget _nullUserPart(double screenSize) {
    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Icon(
                Icons.error,
                size: 75,
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Center(
                    child: Text(
                      "Something went wrong!",
                      style: TextStyle(
                          color: Colors.amberAccent,
                          fontSize: 23,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: Text(
                      "These things could be happened: ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                _errorList("The given username does not exist on github"),
                _errorList("Entered wrong password or/and username"),
                _errorList("GitHub REST API limit is exceeded"),
                SizedBox(height: screenSize / 10),
                _errorList("Please be sure your username and password is correct and re-login. "
                    "If this problem still continue wait 1 hour for reset of GitHub REST API limit and then re-login."),
              ],
            ),
          ],
        ));
  }

  Widget _errorList(String text) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _informationPart(double screenSize, Orientation deviceOrientation,
      AsyncSnapshot snapshot) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.amberAccent,
              child: Padding(
                padding: EdgeInsets.all(screenSize / 60),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        width: deviceOrientation == Orientation.portrait
                            ? screenSize / 2.5
                            : screenSize / 6,
                        height: deviceOrientation == Orientation.portrait
                            ? screenSize / 2.5
                            : screenSize / 6,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.cover,
                                image: new NetworkImage(
                                    snapshot.data.avatar_url)))),
                    Container(
                      child: Column(
                        children: [
                          SizedBox(height: screenSize / 60),
                          Text(
                            snapshot.data.name == null
                                ? 'Null'
                                : snapshot.data.name,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: screenSize / 60),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Following: ${snapshot.data.following}'),
                              SizedBox(width: screenSize / 75),
                              Text('Follower: ${snapshot.data.followers}')
                            ],
                          ),
                          SizedBox(height: screenSize / 60),
                          Text(
                              'Participation Date: ${snapshot.data.created_at}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _repositoriesPart(double screenSize, Orientation deviceOrientation,
      AsyncSnapshot snapshot) {
    return Expanded(
      child: Column(
        children: [
          Container(
            color: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: FlatButton(
                    onPressed: () {
                      Profile.isTrue = false;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Profile()));
                    },
                    child: Text(
                      'Repositories',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    onPressed: () {
                      Profile.isTrue = true;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Profile()));
                    },
                    child: Text(
                      'Notes',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
          Profile.isTrue ?  _notesList(screenSize) : _reposList()
        ],
      ),
    );
  }

  Widget _reposList() {
    return Expanded(
      child: ListView.builder(
          itemCount: reposList.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                  leading: Icon(Icons.account_balance_outlined),
                  title: Text(reposList[index].name),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.amber,
                  )),
            );
          }),
    );
  }

  Widget _notesList(double screenSize) {
    return Expanded(
            child: ListView.builder(
                itemCount: userNotesList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                        leading: Icon(Icons.message_sharp),
                        title: Text(userNotesList[index]['title']),
                        subtitle: Text(userNotesList[index]['context']),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.amber,
                        ),
                        onLongPress: () {
                          NoteFirestore().deleteNote(userNotesList[index]['id']);
                          Profile.isTrue = true;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BottomNavigation()));
                        },
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddNote("Update Note", userNotesList[index]['title'], userNotesList[index]['context'], userNotesList[index]['id'], "Profile")));
                        },
                    ),
                  );
            }),
    );
  }

  Widget _buildVerticalLayout(double screenSize, Orientation deviceOrientation,
      AsyncSnapshot snapshot) {
    return Container(
      child: Column(
        children: [
          _informationPart(screenSize, deviceOrientation, snapshot),
          _repositoriesPart(screenSize, deviceOrientation, snapshot),
        ],
      ),
    );
  }

  Widget _buildHorizontalLayout(double screenSize,
      Orientation deviceOrientation, AsyncSnapshot snapshot) {
    return Container(
      child: Row(
        children: [
          _informationPart(screenSize, deviceOrientation, snapshot),
          _repositoriesPart(screenSize, deviceOrientation, snapshot),
        ],
      ),
    );
  }

  void getReposFromApi() {
    ReposApi.getRepos(Profile.username).then((response) {
      if (response.statusCode == 200) {
        setState(() {
          Iterable list = json.decode(response.body);
          this.reposList = list.map((todo) => Repos.fromJson(todo)).toList();
        });
      } else {
        throw Exception('Warning!');
      }
    });
  }
}
