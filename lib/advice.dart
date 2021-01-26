import 'package:flutter/material.dart';
import 'package:gknow/adviceFirestore.dart';
import 'package:gknow/myDrawer.dart';
import 'showAdvice.dart';
import 'main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
}

class AdvicePage extends StatefulWidget {
  @override
  _AdvicePageState createState() => _AdvicePageState();
}

class _AdvicePageState extends State<AdvicePage> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await AdviceFirestore().fetchAdvicesFirestore();
          final snackBar = SnackBar(content: Text("Advices Updated"));
          Scaffold.of(context).showSnackBar(snackBar);
          setState(() {});
        },
        label: Text('Fetch'),
        icon: Icon(Icons.language_rounded),
        backgroundColor: Colors.black,
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Advices"),
      ),
      body: _buildLayout(screenSize),
    );
  }

  Widget _repositoriesPart(double screenSize) {
    return Expanded(
      child: Column(
        children: [
          _notesList(screenSize),
        ],
      ),
    );
  }

  Widget _notesList(double screenSize) {
    return Expanded(
      child: ListView.builder(
          itemCount: MyApp.adviceList.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                leading: Icon(Icons.message_sharp),
                title: Text(MyApp.adviceList[index]['title']),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.amber,
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => ShowAdvice(
                          MyApp.adviceList[index]['title'],
                          MyApp.adviceList[index]['context'])));
                },
              ),
            );
          }),
    );
  }

  Widget _buildLayout(double screenSize) {
    return Container(
      child: Column(
        children: [
          _repositoriesPart(screenSize),
        ],
      ),
    );
  }
}
