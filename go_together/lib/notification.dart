import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<NotificationPage> {
  late Future<List<dynamic>> _futureNotifications;

  @override
  void initState() {
    super.initState();
    setState(() {
      _futureNotifications = fetchNotifications();
    });
  }

  Future<List<dynamic>> fetchNotifications() async {
    final response = await http
        .get(Uri.parse('http://localhost:3000/getNotificationRider/11'));
    if (response.statusCode == 200) {
      print(json.decode(response.body)['data']);
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to load notifications');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _futureNotifications,
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          final List<dynamic> notifications = snapshot.data!;
          return ListView.builder(
            padding: EdgeInsets.only(bottom: 30),
            itemCount: notifications.length,
            itemBuilder: (BuildContext context, int index) {
              final notification = notifications[index];
              print(notification);
              return ListItemComponent(
                notification['locationSource'],
                notification['locationDestination'],
                notification['name'],
                notification['userID'],
                notification['postID'],
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('${snapshot.error}'),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class ListItemComponent extends StatefulWidget {
  final String source;
  final String des;
  final String name;
  final int id;
  final int postID;

  ListItemComponent(this.source, this.des, this.name, this.id, this.postID);

  @override
  State<ListItemComponent> createState() => _ListItemComponentState();
}

class _ListItemComponentState extends State<ListItemComponent> {
  final _formKey = GlobalKey<FormState>();

  int hidden = 0;

  Future<void> _submitForm() async {
    final response = await http.put(
      Uri.parse('http://localhost:3000/riderRegister'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "postID": "${this.widget.postID}",
        "userID": "${this.widget.id}",
        "status": "1",
      }),
    );
  }

  Future<void> _rejectForm() async {
    final response = await http.delete(
      Uri.parse('http://localhost:3000/riderReject'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "postID": "${this.widget.postID}",
        "userID": "${this.widget.id}",
        "status": "0",
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return [
      Form(
        key: _formKey,
        child: Column(
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
                            Expanded(child: Text(this.widget.source ?? '')),
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
                          Flexible(child: Text(this.widget.des ?? '')),
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
                        "from: ${this.widget.name}}",
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
                      _submitForm();
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
                      _rejectForm();

                      setState(() {
                        hidden = 1;
                      });
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
        ),
      ),
      Container()
    ][hidden];
  }
}
