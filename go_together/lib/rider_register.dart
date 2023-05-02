import 'package:flutter/material.dart';

class RiderRegisterPage extends StatefulWidget {
  @override
  _RiderRegisterState createState() => _RiderRegisterState();
}

class _RiderRegisterState extends State<RiderRegisterPage> {
  bool driving_toggle = false;
  bool carImage_toggle = false;
  bool license_toggle = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
            obscureText: true,
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
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
            obscureText: true,
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
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
            obscureText: true,
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
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
            obscureText: true,
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
              // _submitForm();
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
    );
  }
}
