import 'package:flutter/material.dart';
import 'package:gknow/searchProfile.dart';

import 'myDrawer.dart';

class Search extends StatefulWidget {
  static String username;

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchControl = new TextEditingController();

  //List<String> searchlist = ["Bora Altuntaş", "Emrullah Dağkuşu"];

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Search"),
      ),
      body: _buildLayout(screenSize),
    );
  }

  Widget _buildLayout(double screenSize) {
    return Container(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenSize / 50),
          child: Center(
            child: Column(
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
                GestureDetector(
                  child: Container(
                    height: 50,
                    width: 50,
                    child: Icon(
                      Icons.search,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.amber, shape: BoxShape.circle),
                  ),
                  onTap: () {
                    //Search.username = searchControl.text;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SearchProfile(searchControl.text)));
                  },
                ),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenSize / 40),
                        child: Text(
                          'Search History',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 20,
                  thickness: 2,
                ),
                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenSize / 80),
                        child: Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SearchProfile('mustafamuratcoskun')));
                            },
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://avatars0.githubusercontent.com/u/15064847?v=4"),
                            ),
                            title: Text('mustafamuratcoskun'),
                            subtitle: Text('Mustafa Murat Coşkun'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(screenSize / 80),
                        child: Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SearchProfile('bbaltuntas')));
                            },
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://avatars2.githubusercontent.com/u/57188585?v=4"),
                            ),
                            title: Text('bbaltuntas'),
                            subtitle: Text('Bora Barış Altuntaş'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
