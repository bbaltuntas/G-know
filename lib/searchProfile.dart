import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gknow/repos.dart';
import 'package:gknow/reposApi.dart';

import 'package:http/http.dart' as http;
import 'User.dart';

class SearchProfile extends StatefulWidget {
  String searchName;

  SearchProfile(this.searchName);

  @override
  _SearchProfileState createState() => _SearchProfileState(searchName);
}

class _SearchProfileState extends State<SearchProfile> {
  Future<User> getUser() async {
    var uri = ReposApi.url + "users/" + searchName + ReposApi.query;
    final response = await http.get(Uri.encodeFull(uri));

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Warning!');
    }
  }

  String searchName;

  _SearchProfileState(this.searchName);

  List<Repos> reposList = List<Repos>();

  @override
  void initState() {
    super.initState();
    getReposFromApi();
  }

  @override
  Widget build(BuildContext context) {
    var deviceOrientation = MediaQuery.of(context).orientation;
    var screenSize = MediaQuery.of(context).size.width;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Center(child: Text(searchName)),
          backgroundColor: Colors.black,
        ),
        body: FutureBuilder(
            future: getUser(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
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
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Center(
                        child: Text(
                          "Not Found.",
                          style: TextStyle(
                              color: Colors.amberAccent,
                              fontSize: 23,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                  ],
                ));
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
            }));
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
                            ? screenSize / 2.75
                            : screenSize / 6,
                        height: deviceOrientation == Orientation.portrait
                            ? screenSize / 2.75
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
                          SizedBox(height: screenSize / 75),
                          Text(
                            snapshot.data.name == null
                                ? 'Null'
                                : snapshot.data.name,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: screenSize / 75),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Following: ${snapshot.data.following}'),
                              SizedBox(width: screenSize / 75),
                              Text('Follower: ${snapshot.data.followers}')
                            ],
                          ),
                          SizedBox(height: screenSize / 75),
                          Text(
                              'Participation Date: ${snapshot.data.created_at}'),
                        ],
                      ),
                    ),
                    Container(
                      width: screenSize / 2,
                      child: FlatButton(
                        color: Colors.black,
                        onPressed: () {},
                        child: Text(
                          'Add Favorite',
                          style: TextStyle(color: Colors.white),
                        ),
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
          Expanded(
            child: ListView.builder(
                itemCount: reposList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                        leading: Icon(Icons.message_sharp),
                        title: Text(reposList[index].name),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.amber,
                        )),
                  );
                }),
          ),
        ],
      ),
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
    ReposApi.getRepos(searchName).then((response) {
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
