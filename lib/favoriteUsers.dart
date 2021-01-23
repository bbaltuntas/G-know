import 'package:flutter/material.dart';
import 'package:gknow/DbHelper.dart';
import 'package:gknow/myDrawer.dart';
import 'package:gknow/searchProfile.dart';

class User {
  int id;
  String username;
  String link;
  String addControl = "Add Favorite";

  User(this.username, this.link);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["username"] = username;
    map["link"] = link;
    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    username = map["username"];
    link = map["link"];
  }
}

class FavoriteUsers extends StatefulWidget {
  @override
  _FavoriteUsersState createState() => _FavoriteUsersState();
}

class _FavoriteUsersState extends State<FavoriteUsers> {
  DbHelper _dbHelper;

  @override
  void initState() {
    _dbHelper = DbHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Favorite Users"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.black,
        child: Icon(
          Icons.clear_all,
          color: Colors.amber,
        ),
      ),
      body: _buildLayout(screenSize),
    );
  }

  Widget _buildLayout(double screenSize) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Expanded(
                child: FutureBuilder(
              future: _dbHelper.getUsers(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                if (snapshot.data.isEmpty) return  Center(
                    child: Text("Favorite User List is Empty",
                        style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold)));
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      User user = snapshot.data[index];
                      return Padding(
                        padding: EdgeInsets.all(screenSize / 80),
                        child: Card(
                          child: ListTile(
                            leading: Image.network(user.link),
                            title: Text(user.username),
                            trailing: RaisedButton(
                              onPressed: () async {
                                _dbHelper.removeUser(user.id);
                                SearchProfile.isAdded = false;
                                setState(() {});
                              },
                              child: Icon(
                                Icons.clear,
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              },
            )),
          ],
        ),
      ),
    );
  }
}
