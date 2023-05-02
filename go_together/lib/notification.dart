import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(bottom: 30),
      children: [
        ListItemComponent("S", "D"),
        SizedBox(height: 20),
        ListItemComponent("S", "D"),
        SizedBox(height: 20),
        ListItemComponent("S", "D"),
        SizedBox(height: 20),
        ListItemComponent("S", "D"),
        SizedBox(height: 20),
        ListItemComponent("S", "D"),
        SizedBox(height: 20),
        ListItemComponent("S", "D"),
        SizedBox(height: 20),
        ListItemComponent("S", "D"),
        SizedBox(height: 20),
        ListItemComponent("S", "D"),
        SizedBox(height: 20),
        ListItemComponent("S", "D"),
        SizedBox(height: 20),
        ListItemComponent("S", "D")
      ],
    );
  }
}

class ListItemComponent extends StatelessWidget {
  final String source;
  final String des;

  ListItemComponent(this.source, this.des);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
          decoration: new BoxDecoration(
            color: Color.fromRGBO(243, 243, 243, 1),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 202, 202, 202),
                blurRadius: 8.0, // has the effect of softening the shadow
                spreadRadius: 0, // has the effect of extending the shadow
                offset: Offset(
                  0, // horizontal, move right 10
                  4, // vertical, move down 10
                ),
              )
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.pin_drop_rounded,
                          size: 20,
                          color: Colors.black87,
                        ),
                        SizedBox(width: 10),
                        Expanded(child: Text(this.source)),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Divider(
                          height: 2,
                          color: Colors.black87,
                        ),
                      )),
                      Expanded(
                        child: Divider(
                          height: 2,
                          color: Colors.black87,
                        ),
                      ),
                      Icon(
                        Icons.arrow_right_alt,
                        size: 20,
                        color: Colors.black87,
                      ),
                    ],
                  )),
                  SizedBox(width: 10),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(child: Text(this.des)),
                      SizedBox(width: 10),
                      Icon(
                        Icons.flag,
                        size: 20,
                        color: Colors.black87,
                      ),
                    ],
                  )),
                ],
              ),
              SizedBox(height: 15),
              Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "from: Kotcharat Kung",
                    style: TextStyle(color: Color(0xFF565656)),
                  )),
              SizedBox(height: 10),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  print(1);
                },
                child: Container(
                  height: 30,
                  color: Color(0xFF4EFF55),
                  child: Icon(
                    Icons.check,
                    size: 20,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  print(2);
                },
                child: Container(
                  height: 30,
                  color: Color(0xFFFF5656),
                  child: Icon(
                    Icons.close,
                    size: 20,
                    color: Colors.black87,
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
