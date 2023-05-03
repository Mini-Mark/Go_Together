import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'globals.dart' as globals;

class MapDetail extends StatefulWidget {
  final int postID;

  MapDetail(this.postID);

  @override
  _MapDetailState createState() => _MapDetailState(this.postID);
}

class _MapDetailState extends State<MapDetail> {
  final _formKey = GlobalKey<FormState>();

  bool bigButton = false;

  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _submitForm() async {
    globals.isJoinRider = true;
    globals.isJoinRiderPostID = widget.postID;

    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final response = await http.post(
          Uri.parse('http://localhost:3000/postRequest'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'postID': postID,
            'userID': globals.userData["data"]["userID"],
            'status': '0',
          }),
        );
      } catch (error) {
        // Network error, display error message
        setState(() {
          _errorMessage = 'An error occurred, please try again later.';
          _isLoading = false;
        });
      }
    }
  }

  int button_step = globals.isJoinRider ? 1 : 0;

  final int postID;

  _MapDetailState(this.postID);

  @override
  void initState() {
    super.initState();
    getAPI();
  }

  Map<String, dynamic> jsonMap = {};

  @override
  Future<void> getAPI() async {
    if (globals.isJoinRider) {
      final response = await http.get(
        Uri.parse(
            'http://localhost:3000/postDetail/${globals.isJoinRiderPostID}'),
        headers: {'Content-Type': 'application/json'},
      );
      setState(() {
        jsonMap = json.decode(response.body);
      });

      print(jsonMap["data"][0]["UserStatus"]);
      if (jsonMap["data"][0]["UserStatus"] == "1") {
        bigButton = true;
        print(bigButton);
      }
    } else {
      final response = await http.get(
        Uri.parse('http://localhost:3000/postDetail/${postID}'),
        headers: {'Content-Type': 'application/json'},
      );
      setState(() {
        jsonMap = json.decode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Image.asset(
                      "assets/map.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Row(
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
                              Expanded(
                                child: Text(
                                    jsonMap['data']?[0]?.isNotEmpty == true
                                        ? jsonMap['data'][0]['locationSource']
                                        : ''),
                              )
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
                            Flexible(
                                child: Text(jsonMap['data']?[0]
                                        ?['locationDestination'] ??
                                    '')),
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
                  ),
                  SizedBox(height: 20),
                  Divider(
                    height: 1,
                    color: Colors.black38,
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(150.0),
                        child: Image.asset("assets/user_logo.png",
                            fit: BoxFit.contain, width: 40),
                      ),
                      SizedBox(width: 15),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(jsonMap['data']?[0]?['name'] ?? ''),
                          Text(jsonMap['data']?[0]?['tel'] ?? ''),
                        ],
                      ),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.drive_eta,
                                    size: 20,
                                    color: Colors.black87,
                                  ),
                                  SizedBox(width: 10),
                                  Text(jsonMap['data']?[0]?['licenseNo'] ?? ''),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.airline_seat_recline_normal,
                                    size: 20,
                                    color: Colors.black87,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                      "${jsonMap['data']?[0]?['join_user'] ?? ''} / ${jsonMap['data']?[0]?['seat'] ?? ''}"),
                                ],
                              ),
                            ],
                          ),
                        ],
                      )),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (button_step == 0) {
                    jsonMap['data']?[0]?['join_user'] += 1;
                    _submitForm();
                  }
                  button_step = 1;
                });
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 40,
                child: [
                  Text(
                    "Pick me !",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Text(
                    "Waiting",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    "Rider Accepted",
                    style: TextStyle(fontSize: 18),
                  )
                ][bigButton? 2 : globals.isJoinRider ? 1 : button_step],
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all([
                  Color(0xFF00A8E8),
                  Color(0xFFF8C100),
                  Color.fromARGB(255, 60, 255, 0)
                ][bigButton? 2 : globals.isJoinRider ? 1 : button_step]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
