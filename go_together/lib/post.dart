import 'package:flutter/material.dart';

class Post extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  int button_step = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Column(
        children: [
          Column(
            children: [
              TextFormField(
                // controller: _rePasswordController,
                decoration: InputDecoration(
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
                      // controller: _rePasswordController,
                      decoration: InputDecoration(
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
                      // controller: _rePasswordController,
                      decoration: InputDecoration(
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
              // _submitForm();
            },
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 40,
              child: [
                Text(
                  "Online",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                Text(
                  "Offline",
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
    );
  }
}
