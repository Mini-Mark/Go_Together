import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''), // empty title
        automaticallyImplyLeading: false, // hide back button
        elevation: 0, // remove shadow
        backgroundColor: Colors.transparent, // make transparent
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
          child: Column(
            children: [
              Text(
                "Sign Up",
                style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              SizedBox(height: 15),
              Text(
                "สมัครสมาชิก และสามารถเริ่มใช้งานได้เลย",
                style: TextStyle(fontSize: 18),
              ),
              Container(
                constraints: BoxConstraints(
                  maxWidth: 500,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 40),
                    TextField(
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(),
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Icon(
                                  Icons.account_circle,
                                  size: 20,
                                  color: Colors.black87,
                                ),
                              ),
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
                    SizedBox(height: 40),
                    TextField(
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
                              )
                            ],
                          )),
                    ),
                    SizedBox(height: 40),
                    TextField(
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(),
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
                                "Telephone Number",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              )
                            ],
                          )),
                    ),
                    SizedBox(height: 40),
                    TextField(
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(),
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Icon(
                                  Icons.vpn_key_outlined,
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
                    SizedBox(height: 40),
                    TextField(
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
                                "Re-Password",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              )
                            ],
                          )),
                    )
                  ],
                ),
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
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 250,
                      height: 50,
                      child: Text(
                        "Sign up",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromRGBO(255, 114, 94, 1)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: 'If you have an account please ',
                  ),
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Navigator.pushNamed(context, '/login'),
                    text: 'Sign in',
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
