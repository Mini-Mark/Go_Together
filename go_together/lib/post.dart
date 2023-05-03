import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'globals.dart' as globals;

class Post extends StatefulWidget {
  final Function toggleRiderStatus;
  final bool status;

  Post({required this.toggleRiderStatus, required this.status});

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  final _formKey = GlobalKey<FormState>();
  final _locationSourceController = TextEditingController();
  final _locationDestinationController = TextEditingController();
  final _seatController = TextEditingController();

  String _status = '';
  int button_step = 0;

  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        final response = await http.post(
          Uri.parse('http://localhost:3000/riderPost'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            "userID": "5",
            "locationSource": _locationSourceController.text,
            "locationDestination": _locationDestinationController.text,
            "seat": _seatController.text,
            "online": "${_status}"
          }),
        );

        globals.postData = {
          "source": _locationSourceController.text,
          "destination": _locationDestinationController.text,
          "seat": _seatController.text
        };

        Map<String, dynamic> jsonMap = json.decode(response.body);
        print(jsonMap['status']);
        if (jsonMap['status'] == true) {
          // Registration successful, navigate to home screen
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Post Successful'),
                content: Text('Post Successful'),
                actions: [
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      // Navigator.pushNamed(context, '/login');
                    },
                  ),
                ],
              );
            },
          );
        } else {
          // Registration failed, display error message
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Registration Failed'),
                content: Text('Email already exists'),
                actions: [
                  TextButton(
                    child: Text('OK'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              );
            },
          );
          setState(() {
            _errorMessage = 'Email already exists';
            _isLoading = false;
          });
        }
      } catch (error) {
        // Network error, display error message
        setState(() {
          _errorMessage = 'An error occurred, please try again later.';
          _isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.status) {
      button_step = 1;
    } else {
      button_step = 0;
    }

    _locationSourceController.text = globals.postData?["source"] ?? '';
    _locationDestinationController.text =
        globals.postData?["destination"] ?? '';
    _seatController.text = globals.postData?["seat"] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Column(
              children: [
                TextFormField(
                  enabled: (button_step == 0),
                  controller: _locationSourceController,
                  decoration: InputDecoration(
                      filled: !(button_step == 0),
                      fillColor:
                          (button_step == 0) ? Colors.white : Colors.black12,
                      focusedBorder: OutlineInputBorder(),
                      border: OutlineInputBorder(),
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(
                              Icons.pin_drop_sharp,
                              size: 20,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            "Source",
                            style: TextStyle(
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 2,
                      child: TextFormField(
                        enabled: (button_step == 0),
                        controller: _locationDestinationController,
                        decoration: InputDecoration(
                            filled: !(button_step == 0),
                            fillColor: (button_step == 0)
                                ? Colors.white
                                : Colors.black12,
                            focusedBorder: OutlineInputBorder(),
                            border: OutlineInputBorder(),
                            label: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Icon(
                                    Icons.flag,
                                    size: 20,
                                    color: Colors.black87,
                                  ),
                                ),
                                Text(
                                  "Destination",
                                  style: TextStyle(
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(
                      flex: 1,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        enabled: (button_step == 0),
                        controller: _seatController,
                        decoration: InputDecoration(
                            filled: !(button_step == 0),
                            fillColor: (button_step == 0)
                                ? Colors.white
                                : Colors.black12,
                            focusedBorder: OutlineInputBorder(),
                            border: OutlineInputBorder(),
                            label: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Icon(
                                    Icons.airline_seat_recline_normal,
                                    size: 20,
                                    color: Colors.black87,
                                  ),
                                ),
                                Text(
                                  "Seat",
                                  style: TextStyle(
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Image.asset(
                      "assets/map.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  button_step = (button_step == 1 ? 0 : 1);
                });

                widget.toggleRiderStatus();
                if (button_step == 0) {
                  _status = 'True';
                  _submitForm();
                } else {
                  _status = 'False';
                  _submitForm();
                }
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 40,
                child: [
                  Text(
                    "Go online !",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  Text(
                    "Return to offline",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  )
                ][button_step],
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    [Color(0xFF4EFF55), Color(0xFFFF5656)][button_step]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
