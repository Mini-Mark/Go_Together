import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_together/history.dart';
import 'package:go_together/list.dart';
import 'package:go_together/notification.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool role = false;
  int currentPage = 0;

  changePage(page) {
    setState(() {
      currentPage = page;
    });
  }

  toggleRole() {
    setState(() {
      role = !role;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.fromLTRB(18,20,18,0),
            child: [
              ListPage(),
              HistoryPage(),
              NotificationPage(),
              Home()
            ][currentPage]),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: Text("List",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color: Colors.black87)),
          actions: [
            Container(
              padding: EdgeInsets.only(right: 10),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text("user",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                        )),
                  ),
                  CupertinoSwitch(
                      trackColor: Colors.grey,
                      activeColor: Colors.black,
                      value: role,
                      onChanged: (e) => {toggleRole()})
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.black,
          child: GNav(
              backgroundColor: Colors.black,
              color: Colors.white,
              activeColor: Color(0xFFFD4910),
              gap: 8,
              selectedIndex: currentPage,
              onTabChange: (page) => {changePage(page)},
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.history,
                  text: 'History',
                ),
                GButton(
                  icon: Icons.notifications_none_sharp,
                  text: 'Notification',
                ),
                GButton(
                  icon: Icons.list,
                  text: 'Menu',
                )
              ]),
        ));
  }
}
