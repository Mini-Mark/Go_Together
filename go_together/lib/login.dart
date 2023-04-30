import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(10.0, 50, 10.0, 0),
                child: Image.asset('assets/start_banner.png',
                    fit: BoxFit.contain, width: 500)),
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
                child: Column(children: [
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
                  SizedBox(height: 20),
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
          ],
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
                      Navigator.pushNamed(context, '/home');
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