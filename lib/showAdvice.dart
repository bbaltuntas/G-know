import 'package:flutter/material.dart';

class ShowAdvice extends StatefulWidget {
  String title;
  String context;

  ShowAdvice(this.title, this.context);

  @override
  _ShowAdviceState createState() => _ShowAdviceState(title, context);
}

class _ShowAdviceState extends State<ShowAdvice> {
  String title;
  String adviceContext;


  _ShowAdviceState(this.title, this.adviceContext);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              child:  Text(adviceContext,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
