import 'package:flutter/material.dart';

class OpenSourceLicences extends StatefulWidget {
  @override
  _OpenSourceLicencesState createState() => _OpenSourceLicencesState();
}

class _OpenSourceLicencesState extends State<OpenSourceLicences> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Terms of Services'),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(screenSize / 20),
                    child: Text(
                      'Copyright <2021> <G-Know>',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.amberAccent),
                    ),
                  ),
                  Text(
                    "Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the \"Software\"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: screenSize / 20),
                  Text(
                      "The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.justify),
                  SizedBox(height: screenSize / 20),
                  Text(
                      "THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.justify),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
