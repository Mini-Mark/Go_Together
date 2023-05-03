import 'package:flutter/material.dart';
import 'package:go_together/map_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListPage extends StatefulWidget {
  Function setLeading;
  Function setTitle;

  int page;

  ListPage(
      {required this.setLeading, required this.setTitle, required this.page});

  @override
  _ListState createState() => _ListState();
}

class _ListState extends State<ListPage> {
  final _formKey = GlobalKey<FormState>();
  final _keywordController = TextEditingController();

  bool _isLoading = false;
  String _errorMessage = '';

  String keyword = "";
  int _currentPage = 0;

  int _postID = 0;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.page;
  }

  changePage(int pg, int postID) {
    setState(() {
      _currentPage = pg;
      _postID = postID;
    });

    if (pg == 1) {
      widget.setLeading(true);
      widget.setTitle("Detail");
    }
  }

  Future<void> _submitForm() async {
    keyword = _keywordController.text;
  }

  @override
  Widget build(BuildContext context) {
    return [
      Container(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: TextFormField(
              controller: _keywordController,
              onChanged: (_keywordController) {
                setState(() {
                  keyword = _keywordController;
                });
              },
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.search,
                          size: 20,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        "Search",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      )
                    ],
                  )),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: keyword != null
                  ? http.get(Uri.parse(
                      "http://localhost:3000/userList?locationDestination=$keyword"))
                  : http.get(Uri.parse("http://localhost:3000/userList")),
              builder: (BuildContext context,
                  AsyncSnapshot<http.Response> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  // print(snapshot.data!.body);
                  if (json.decode(snapshot.data!.body)["data"].isEmpty) {
                    return Container();
                  } else {
                    var data = json.decode(snapshot.data!.body)["data"];
                    return ListView.builder(
                      padding: EdgeInsets.only(bottom: 30),
                      scrollDirection: Axis.vertical,
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        var item = data[index];
                        return Column(
                          children: [
                            (item["join_user"] >= item["seat"])
                                ? Container()
                                : ListItemComponent(
                                    item["locationSource"],
                                    item["locationDestination"],
                                    item["postID"],
                                    () => changePage(1, item["postID"]),
                                    item["name"],
                                    item["tel"],
                                    item["seat"],
                                    item["join_user"]),
                            SizedBox(height: 10),
                          ],
                        );
                      },
                    );
                  }
                }
              },
            ),
          ),
        ],
      )),
      MapDetail(_postID)
    ][_currentPage];
  }
}

class ListItemComponent extends StatelessWidget {
  final String source;
  final String des;
  final int postID;

  final String name;
  final String tel;
  final int seat;

  final Function page;

  final int join_user;

  ListItemComponent(this.source, this.des, this.postID, this.page, this.name,
      this.tel, this.seat, this.join_user);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        page();
      },
      color: Color.fromARGB(255, 168, 168, 168),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
          decoration: new BoxDecoration(
            color: Color.fromRGBO(250, 250, 250, 1),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 218, 218, 218),
                blurRadius: 8.0, // has the effect of softening the shadow
                spreadRadius: 0, // has the effect of extending the shadow
                offset: Offset(
                  0, // horizontal, move right 10
                  4, // vertical, move down 10
                ),
              )
            ],
          ),
          child: Column(
            children: [
              Row(
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
                        Expanded(child: Text(this.source)),
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
                      Flexible(child: Text(this.des)),
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
              SizedBox(height: 10),
              Divider(
                height: 1,
                color: Colors.black38,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(150.0),
                    child: Image.asset("assets/user_logo.png",
                        fit: BoxFit.contain, width: 40),
                  ),
                  SizedBox(width: 15),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${name}"),
                      Text("${tel}"),
                    ],
                  ),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.airline_seat_recline_normal,
                        size: 20,
                        color: Colors.black87,
                      ),
                      SizedBox(width: 10),
                      Text("${join_user} / ${seat}"),
                    ],
                  )),
                ],
              )
            ],
          )),
    );
  }
}
