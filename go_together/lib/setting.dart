import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<SettingPage> {
  bool allowChangePassword = false;

  final _NameController = TextEditingController();
  final _TelController = TextEditingController();

  @override
  void initState() {
    super.initState();

    setState(() {
      _NameController.text = 'John Doe';
      _TelController.text = '123-456-7890';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
                      controller: _NameController,
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
                      controller: _TelController,
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
                    SizedBox(height: 5),
                    Text(
                      "222222222222222",
                    ),
                  ],
                ),
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
