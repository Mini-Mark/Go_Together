import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool role = false;

  toggleRole() {
    setState(() {
      role = !role;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        Container(
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Text("user",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                    )),
              ),
              CupertinoSwitch(
                  trackColor: Colors.grey,
                  activeColor: Colors.black,
                  value: role,
                  onChanged: (e) => {toggleRole()})
            ],
          ),
        )
      ],
    ));
  }
}
