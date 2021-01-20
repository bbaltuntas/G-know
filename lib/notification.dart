import 'package:flutter/material.dart';
import 'package:gknow/myDrawer.dart';

class Notification {
  String context;
  String date;

  Notification(this.context, this.date);
}

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  Notification notification1 = Notification("You have one follower", "20.35");
  Notification notification2 =
      Notification("emrdagkusu leave a start to your project", "17.35");
  Notification notification3 =
      Notification("bbaltuntas has deleted a repository", "05.35");
  Notification notification4 =
      Notification("emrdagkusu forked your mobil programming project", "20.35");
  Notification notification5 =
      Notification("bbaltuntas started the project HTML", "23.35");
  Notification notification6 =
      Notification("emrdagkusu started to watch your repository", "07.35");
  Notification notification7 =
      Notification("bbaltuntas started to watch your repository", "10.35");

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.black,
        child: Icon(
          Icons.clear_all,
          color: Colors.amberAccent,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Notification"),
      ),
      body: _buildLayout(screenSize),
    );
  }

  Widget _buildLayout(double screenSize) {
    List<Notification> notificiatonsList = [
      notification1,
      notification2,
      notification3,
      notification4,
      notification5,
      notification6,
      notification7
    ];

    return Container(
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: notificiatonsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.all(screenSize / 80),
                      child: Card(
                        child: ListTile(
                            leading: Icon(Icons.message_sharp),
                            title: Text(notificiatonsList[index].context),
                            subtitle: Text(notificiatonsList[index].date),
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
