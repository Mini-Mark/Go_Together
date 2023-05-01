import 'package:flutter/material.dart';
import 'package:go_together/map_detail.dart';

class ListPage extends StatefulWidget {
  @override
  _ListState createState() => _ListState();
}

class _ListState extends State<ListPage> {
  int _currentPage = 0;

  changePage(int pg) {
    setState(() {
      _currentPage = pg;
    });
  }

  @override
  Widget build(BuildContext context) {
    return [
      Container(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: TextField(
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.search,
                          size: 20,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        "Search",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      )
                    ],
                  )),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(bottom: 30),
              scrollDirection: Axis.vertical,
              children: [
                ListItemComponent("S", "D", () => changePage(1)),
                SizedBox(height: 10),
                ListItemComponent("A", "B", () => changePage(1))
              ],
            ),
          )
        ],
      )),
      MapDetail()
    ][_currentPage];
  }
}

class ListItemComponent extends StatelessWidget {
  final String source;
  final String des;

  final Function page;

  ListItemComponent(this.source, this.des, this.page);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        page();
      },
      color: Color.fromARGB(255, 168, 168, 168),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
          decoration: new BoxDecoration(
            color: Color.fromRGBO(250, 250, 250, 1),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 218, 218, 218),
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
                      Flexible(child: Text("Des")),
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
              SizedBox(height: 10),
              Divider(
                height: 1,
                color: Colors.black38,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Image.asset("assets/user_logo.png",
                      fit: BoxFit.contain, width: 40),
                  SizedBox(width: 15),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Mon"),
                      Text("081-2345678"),
                    ],
                  ),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.airline_seat_recline_normal,
                        size: 20,
                        color: Colors.black87,
                      ),
                      SizedBox(width: 10),
                      Text("0 / 4"),
                    ],
                  )),
                ],
              )
            ],
          )),
    );
  }
}
