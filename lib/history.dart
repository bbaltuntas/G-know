import 'package:flutter/material.dart';
import 'package:gknow/DbHelperHistory.dart';
import 'package:gknow/myDrawer.dart';
import 'package:gknow/searchProfile.dart';
import 'favoriteUsers.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  DbHelperHistory _dbHelperHistory;

  @override
  void initState() {
    _dbHelperHistory = DbHelperHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Search History"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _dbHelperHistory.removeAll();
          _dbHelperHistory.initDb();
          setState(() {});
        },
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
              child: Container(
                child: SizedBox(
                  height: 10,
                  child: FutureBuilder(
                    future: _dbHelperHistory.getHistory(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<User>> snapshot) {
                      if (!snapshot.hasData) return CircularProgressIndicator();
                      if (snapshot.data.isEmpty)
                        return Center(
                            child: Text("History List is Empty",
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
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SearchProfile(user.username)));
                                  },
                                  leading: Image.network(user.link),
                                  title: Text(user.username),
                                ),
                              ),
                            );
                          });
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
