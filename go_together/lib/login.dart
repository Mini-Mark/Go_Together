import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'globals.dart' as globals;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final response = await http.post(
          Uri.parse('http://localhost:3000/login'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'email': _emailController.text,
            'password': _passwordController.text,
          }),
        );
        Map<String, dynamic> jsonMap = json.decode(response.body);

        print(jsonMap);

        if (jsonMap['status'] == true) {
          // Login successful, navigate to home screen
          globals.isLoggedIn = true;
          globals.userData = jsonMap;

          final response_checkJoinRider = await http.get(
            Uri.parse(
                "http://localhost:3000/postStatus/${jsonMap["data"]["userID"]}"),
          );
          Map<String, dynamic> checkJoinRider =
              json.decode(response_checkJoinRider.body);
          if (checkJoinRider["message"] == "Success") {
            globals.isJoinRider = true;
            globals.isJoinRiderPostID = checkJoinRider["postID"];
          } else {
            globals.isJoinRider = false;
            globals.isJoinRiderPostID = null;
          }

          final response_checkRiderStatus = await http.get(
            Uri.parse(
                "http://localhost:3000/riderStatus/${jsonMap["data"]["userID"]}"),
          );
          Map<String, dynamic> checkRiderStatus =
              json.decode(response_checkRiderStatus.body);
          if (checkRiderStatus["message"] == "Success") {
            globals.isRiderOnline = (checkRiderStatus["status"] == "True");
          } else {
            globals.isRiderOnline = false;
          }

          Navigator.pushNamed(context, '/home');
        } else {
          // Login failed, display error message

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Login Failed'),
                content: Text('Email or password is incorrect.'),
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
            _errorMessage = 'Email or password is incorrect';
            _isLoading = false;
          });
        }
      } catch (error) {
        // Network error, display error message
        setState(() {
          _errorMessage = 'Could not connect to server';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 50, 10.0, 0),
                child: Image.asset(
                  'assets/start_banner.png',
                  fit: BoxFit.contain,
                  width: 500,
                ),
              ),
              SizedBox(height: 15),
              Text(
                "Welcome Back",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Text(
                "ยินดีต้อนรับเข้าสู่ Go Together ไปด้วยกันนะ",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 50),
              Container(
                constraints: BoxConstraints(
                  maxWidth: 500,
                ),
                padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: Form(
                    key: _formKey,
                    child: Column(children: [
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(),
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Icon(
                                  Icons.email,
                                  size: 20,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                "Email KMITL",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
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
                                  "Password",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                )
                              ],
                            )),
                      ),
                    ])),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
          height: 120,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Navigator.pushNamed(context, '/home');
                      _submitForm();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 250,
                      height: 50,
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromRGBO(255, 114, 94, 1)),
                    ),
                  )
                ],
              ),
              SizedBox(height: 15),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: 'if you don’t have account please ',
                  ),
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Navigator.pushNamed(context, '/register'),
                    text: 'Sign up',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                ], style: TextStyle(color: Colors.black87)),
              )
            ],
          )),
    );
  }
}
