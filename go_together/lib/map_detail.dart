import 'package:flutter/material.dart';

class MapDetail extends StatefulWidget {
  @override
  _MapDetailState createState() => _MapDetailState();
}

class _MapDetailState extends State<MapDetail> {
  int button_step = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Image.asset(
                    "assets/map.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(
                              Icons.pin_drop_rounded,
                              size: 20,
                              color: Colors.black87,
                            ),
                            SizedBox(width: 10),
                            Expanded(child: Text("S")),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Divider(
                              height: 2,
                              color: Colors.black87,
                            ),
                          )),
                          Expanded(
                            child: Divider(
                              height: 2,
                              color: Colors.black87,
                            ),
                          ),
                          Icon(
                            Icons.arrow_right_alt,
                            size: 20,
                            color: Colors.black87,
                          ),
                        ],
                      )),
                      SizedBox(width: 10),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(child: Text("D")),
                          SizedBox(width: 10),
                          Icon(
                            Icons.flag,
                            size: 20,
                            color: Colors.black87,
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Divider(
                  height: 1,
                  color: Colors.black38,
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Image.asset("assets/user_logo.png",
                        fit: BoxFit.contain, width: 40),
                    SizedBox(width: 15),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Mon"),
                        Text("081-2345678"),
                      ],
                    ),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.drive_eta,
                                  size: 20,
                                  color: Colors.black87,
                                ),
                                SizedBox(width: 10),
                                Text("กย 122"),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.airline_seat_recline_normal,
                                  size: 20,
                                  color: Colors.black87,
                                ),
                                SizedBox(width: 10),
                                Text("0 / 4"),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                button_step = 1;
              });
              // _submitForm();
            },
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 40,
              child: [
                Text(
                  "Pick me !",
                  style: TextStyle(fontSize: 18,color: Colors.white),
                ),
                Text(
                  "Waiting",
                  style: TextStyle(fontSize: 18),
                )
              ][button_step],
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  [Color(0xFF00A8E8), Color(0xFFF8C100)][button_step]),
            ),
          )
        ],
      ),
    );
  }
}
