import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_together/home.dart';
import 'package:go_together/login.dart';
import 'package:go_together/register.dart';

void main() {
  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      primary: Color(0xFFD9D9D9), onPrimary: Colors.black87);

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: buttonStyle,
      ),
    ),
    initialRoute: '/',
    routes: {
      '/login': (context) => Login(),
      '/register': (context) => Register(),
      '/home': (context) => Home(),
    },
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              child: Image.asset('assets/start_banner.gif',
                  fit: BoxFit.contain, width: 500)),
          SizedBox(height: 15),
          Text(
            "Go Together",
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
          Text(
            "ยินดีต้อนรับเข้าสู่ Go Together ไปด้วยกันนะ",
            style: TextStyle(fontSize: 18),
          )
        ],
      ),
    ));
  }
}
