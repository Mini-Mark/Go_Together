import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<SettingPage> {
  bool allowChangePassword = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Row(
            children: [
              SizedBox(
                  height: 100,
                  child: Expanded(child: Image.asset("assets/user_logo.png"))),
              SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // TextField(),
                      Text(
                        "33333333333",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.edit,
                        size: 20,
                        color: Colors.black87,
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        "1111111111",
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.edit,
                        size: 20,
                        color: Colors.black87,
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    "222222222222222",
                  ),
                ],
              ),
            ],
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
            Icon(
              Icons.edit,
              size: 20,
              color: Colors.black87,
            ),
          ],
        ),
        SizedBox(height: 10),
        TextFormField(
          enabled: allowChangePassword,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your password';
            }
            return null;
          },
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
          enabled: allowChangePassword,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your password';
            }
            return null;
          },
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
          enabled: allowChangePassword,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your password';
            }
            return null;
          },
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
          onPressed: () {},
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
        )
      ],
    );
  }
}
