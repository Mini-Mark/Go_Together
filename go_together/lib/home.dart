import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    bool role = true;

    return Scaffold(
        appBar: AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      title: Text("List",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
              color: Colors.black87)),
      actions: [
        Text("Test",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 18,
            ))
      ],
    ));
  }
}
