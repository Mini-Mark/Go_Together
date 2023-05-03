import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'globals.dart' as globals;

class SettingPage extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<SettingPage> {
  bool allowChangePassword = false;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _telController = TextEditingController();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _rePasswordController = TextEditingController();

  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();

    setState(() {
      _nameController.text = globals.userData["data"]["name"];
      _telController.text = globals.userData["data"]["tel"];
    });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        if (_newPasswordController.text != _rePasswordController.text) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Password not match'),
                content: Text('Please check your password again'),
                actions: [
                  TextButton(
                    child: Text('OK'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              );
            },
          );
          return;
        } else {
          final response = await http.put(
            Uri.parse('http://localhost:3000/settings'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
              'userID': globals.userData["data"]["userID"],
              'name': _nameController.text,
              'tel': _telController.text,
              'oldPassword': _oldPasswordController.text,
              'password': _newPasswordController.text,
            }),
          );

          Map<String, dynamic> jsonMap = json.decode(response.body);
          print(jsonMap['status']);
          if (jsonMap['status'] == true) {
            // Registration successful, navigate to home screen
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Updated Successful'),
                  content: Text('User profile updated successfully'),
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
                  title: Text('Updated Failed'),
                  content: Text('User profile updated Failed'),
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
              _errorMessage = 'User profile updated Failed';
              _isLoading = false;
            });
          }
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
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Form(
            key: _formKey,
            child: Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(150.0),
                    child: Image.asset(
                      "assets/user_logo.png",
                      width: 125,
                    )),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        // onChanged: (_keywordController) {
                        //   setState(() {
                        //     keyword = _keywordController;
                        //   });
                        // },
                        decoration: InputDecoration(
                            label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Name",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            )
                          ],
                        )),
                      ),
                      SizedBox(height: 5),
                      TextFormField(
                        controller: _telController,
                        // onChanged: (_keywordController) {
                        //   setState(() {
                        //     keyword = _keywordController;
                        //   });
                        // },
                        decoration: InputDecoration(
                            label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(
                                Icons.phone,
                                size: 20,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              "Tel",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            )
                          ],
                        )),
                      ),
                      SizedBox(height: 15),
                      Container(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: 'Email: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            TextSpan(
                                text: '${globals.userData["data"]["email"]}',
                                style: TextStyle(color: Colors.black)),
                          ])))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        Divider(
          height: 1,
          color: Colors.black38,
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Text(
              "Change Password",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                setState(() {
                  allowChangePassword = !allowChangePassword;
                });
              },
              child: Icon(
                Icons.edit,
                size: 20,
                color: Colors.black87,
              ),
            )
          ],
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: _oldPasswordController,
          enabled: allowChangePassword,
          // validator: (value) {
          //   if (value!.isEmpty) {
          //     return 'Please enter your password';
          //   }
          //   return null;
          // },
          obscureText: true,
          decoration: InputDecoration(
              filled: !allowChangePassword,
              fillColor: allowChangePassword ? Colors.white : Colors.black12,
              focusedBorder: OutlineInputBorder(),
              border: OutlineInputBorder(),
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.lock_clock,
                      size: 20,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    "Old Password",
                    style: TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                ],
              )),
        ),
        SizedBox(height: 20),
        TextFormField(
          controller: _newPasswordController,
          enabled: allowChangePassword,
          // validator: (value) {
          //   if (value!.isEmpty) {
          //     return 'Please enter your password';
          //   }
          //   return null;
          // },
          obscureText: true,
          decoration: InputDecoration(
              filled: !allowChangePassword,
              fillColor: allowChangePassword ? Colors.white : Colors.black12,
              focusedBorder: OutlineInputBorder(),
              border: OutlineInputBorder(),
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.key,
                      size: 20,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    "New Password",
                    style: TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                ],
              )),
        ),
        SizedBox(height: 20),
        TextFormField(
          controller: _rePasswordController,
          enabled: allowChangePassword,
          obscureText: true,
          decoration: InputDecoration(
              filled: !allowChangePassword,
              fillColor: allowChangePassword ? Colors.white : Colors.black12,
              focusedBorder: OutlineInputBorder(),
              border: OutlineInputBorder(),
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.key,
                      size: 20,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    "Re Password",
                    style: TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                ],
              )),
        ),
        SizedBox(height: 20),
        Divider(
          height: 1,
          color: Colors.black38,
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            _submitForm();
            setState(() => (allowChangePassword = false));
          },
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 40,
            child: Text(
              "Edit Rider Profile",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.normal),
            ),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(0xFF00F836)),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 10),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 40,
                child: Text(
                  "Logout",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.normal),
                ),
              ),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Color.fromARGB(255, 248, 0, 0)),
              ),
            ),
          ),
        )
      ],
    );
  }
}
