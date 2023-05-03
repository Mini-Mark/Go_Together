import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_together/history.dart';
import 'package:go_together/list.dart';
import 'package:go_together/notification.dart';
import 'package:go_together/post.dart';
import 'package:go_together/rider_register.dart';
import 'package:go_together/setting.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'globals.dart' as globals;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool rider_isOnline = false;
  bool role = false;
  int currentPage = 0;
  String title = "List";
  bool backButton = false;

  toggleRiderStatus() {
    setState(() {
      rider_isOnline = !rider_isOnline;
    });
  }

  changePage(page) {
    setState(() {
      currentPage = page;
      if (!this.role) {
        switch (currentPage) {
          case 0:
            setTitle("List");
            setLeading(false);
            break;
          case 1:
            setTitle("History");
            setLeading(false);
            break;
          case 2:
            setTitle("Notification");
            setLeading(false);
            break;
          case 3:
            setTitle("Settings");
            setLeading(false);
            break;
          default:
        }
      } else {
        switch (currentPage) {
          case 0:
            setLeading(false);
            globals.userData["data"]["drivingLicense"] != null
                ? setTitle("Post")
                : setTitle("Rider Register");
            break;
          case 1:
            setTitle("History");
            setLeading(false);
            break;
          case 2:
            setTitle("Notification");
            setLeading(false);
            break;
          case 3:
            setTitle("Settings");
            setLeading(false);
            break;
          default:
        }
      }
    });
  }

  setTitle(String title_param) {
    setState(() {
      title = title_param;
    });
  }

  setLeading(bool status) {
    // setState(() {
    //   backButton = status;
    // });
  }

  void toggleRole() {
    setState(() {
      role = !role;
      changePage(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.fromLTRB(18, 20, 18, 0),
            child: [
              [
                ListPage(setLeading: setLeading, setTitle: setTitle,page: 0),
                null,
                null,
                SettingPage(),
              ],
              [
                globals.userData["data"]["drivingLicense"] != null
                    ? Post(
                        toggleRiderStatus: this.toggleRiderStatus,
                        status: rider_isOnline)
                    : RiderRegisterPage(
                        registerFinishPage: () => changePage(0)),
                null,
                NotificationPage(),
                SettingPage(),
              ]
            ][role ? 1 : 0][currentPage]),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: backButton,
          leading: backButton
              ? IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                )
              : null,
          title: Text(title,
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
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          this.role
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 3),
                                  child: Icon(
                                    Icons.circle,
                                    size: 10,
                                    color: rider_isOnline
                                        ? Color(0xFF4EFF55)
                                        : Colors.red,
                                  ),
                                )
                              : Container(),
                          SizedBox(width: 7),
                          Text(this.role ? "rider" : "user",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18,
                              )),
                        ],
                      )),
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
                  icon: Icons.settings,
                  text: 'Setting',
                )
              ]),
        ));
  }
}
