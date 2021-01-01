import 'package:flutter/material.dart';

class User {
  String username;
  String link;

  User(this.username, this.link);
}

class FavoriteUsers extends StatefulWidget {
  @override
  _FavoriteUsersState createState() => _FavoriteUsersState();
}

class _FavoriteUsersState extends State<FavoriteUsers> {
  User user1 = User(
      "bbaltuntas", "https://avatars2.githubusercontent.com/u/57188585?v=4");
  User user2 = User("mustafamuratcoskun",
      "https://avatars0.githubusercontent.com/u/15064847?v=4");
  User user3 =
      User("ebru", "https://avatars1.githubusercontent.com/u/45464584?v=4");
  User user4 =
      User("hbusul", "https://avatars2.githubusercontent.com/u/25043169?v=4");
  User user5 = User("mabdullahsoyturk",
      "https://avatars0.githubusercontent.com/u/25618191?v=4");

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.black,
        child: Icon(
          Icons.clear_all,
          color: Colors.amber,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Favorite Users"),
      ),
      body: _buildLayout(screenSize),
    );
  }

  Widget _buildLayout(double screenSize) {
    List<User> userList = [user1, user2, user3, user4, user5];

    return Container(
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.all(screenSize / 80),
                      child: Card(
                        child: ListTile(
                            leading: Image.network(userList[index].link),
                            title: Text(userList[index].username),
                            trailing: Icon(
                              Icons.clear,
                              color: Colors.amber,
                            )),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
