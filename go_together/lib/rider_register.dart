import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'globals.dart' as globals;

class RiderRegisterPage extends StatefulWidget {
  Function registerFinishPage;

  RiderRegisterPage({required this.registerFinishPage});

  @override
  _RiderRegisterState createState() => _RiderRegisterState();
}

class _RiderRegisterState extends State<RiderRegisterPage> {
  bool driving_toggle = false;
  bool carImage_toggle = false;
  bool license_toggle = false;

  final _formKey = GlobalKey<FormState>();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _colorController = TextEditingController();
  final _licenseNoController = TextEditingController();

  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final response = await http.put(
          Uri.parse('http://localhost:3000/riderRegister'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            "userID": "2",
            "brand": _brandController.text,
            "model": _modelController.text,
            "color": _colorController.text,
            "licenseNo": _licenseNoController.text,
            "drivingLicense": "drivingLicense.png",
            "carImage": "carImage.png",
            "carLicense": "carLicense.png"
          }),
        );
        Map<String, dynamic> jsonMap = json.decode(response.body);
        print(jsonMap['status']);
        if (jsonMap['status'] == true) {
          // Registration successful, navigate to home screen
          globals.userData["data"]["brand"] = _brandController.text;
          globals.userData["data"]["model"] = _modelController.text;
          globals.userData["data"]["color"] = _colorController.text;
          globals.userData["data"]["licenseNo"] = _licenseNoController.text;
          globals.userData["data"]["drivingLicense"] = "drivingLicense.png";
          globals.userData["data"]["carImage"] = "carImage.png";
          globals.userData["data"]["carLicense"] = "carLicense.png";
          
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Registration Successful'),
                content: Text('Rider Registration Successful'),
                actions: [
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      widget.registerFinishPage();
                    },
                  ),
                ],
              );
            },
          );
        } else {
          // Registration failed, display error message
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Registration Failed'),
                content: Text('Rider Registration Successful'),
                actions: [
                  TextButton(
                    child: Text('OK'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              );
            },
          );
          setState(() {
            _errorMessage = 'Rider Registration Successful';
            _isLoading = false;
          });
        }
      } catch (error) {
        // Network error, display error message
        setState(() {
          _errorMessage = 'An error occurred, please try again later.';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _brandController,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(),
                  border: OutlineInputBorder(),
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.drive_eta,
                          size: 20,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        "Brand",
                        style: TextStyle(
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: _modelController,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(),
                  border: OutlineInputBorder(),
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.text_fields_rounded,
                          size: 20,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        "Model",
                        style: TextStyle(
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: _colorController,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(),
                  border: OutlineInputBorder(),
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.color_lens,
                          size: 20,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        "Color",
                        style: TextStyle(
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: _licenseNoController,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(),
                  border: OutlineInputBorder(),
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.my_library_books_outlined,
                          size: 20,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        "License No.",
                        style: TextStyle(
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: 15,
            ),
            (driving_toggle
                ? Image.asset(
                    'assets/car_driving.jpg',
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        driving_toggle = !driving_toggle;
                      });
                    },
                    child: Container(
                        height: 250,
                        width: double.infinity,
                        color: Colors.black87,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_search_rounded,
                              size: 50,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Choose Driving Image",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        )),
                  )),
            SizedBox(
              height: 15,
            ),
            (carImage_toggle
                ? Image.asset(
                    'assets/car_image.jpg',
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        carImage_toggle = !carImage_toggle;
                      });
                    },
                    child: Container(
                        height: 250,
                        width: double.infinity,
                        color: Colors.black87,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_search_rounded,
                              size: 50,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Choose Car image",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        )),
                  )),
            SizedBox(
              height: 15,
            ),
            (license_toggle
                ? Image.asset(
                    'assets/car_license.jpg',
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        license_toggle = !license_toggle;
                      });
                    },
                    child: Container(
                        height: 250,
                        width: double.infinity,
                        color: Colors.black87,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_search_rounded,
                              size: 50,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Choose License Image",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        )),
                  )),
            SizedBox(
              height: 15,
            ),
            Divider(
              height: 1,
              color: Colors.black45,
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                _submitForm();
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 40,
                child: Text(
                  "Register",
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFF4EFF55)),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
