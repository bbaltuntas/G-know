import 'package:flutter/material.dart';

class Miss extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var deviceOrientation = MediaQuery.of(context).orientation;
    var screenSize = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("We Miss You !"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
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
              "Welcome, long time no see !",
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}