import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class RiderRegisterPage extends StatefulWidget {
  @override
  _RiderRegisterState createState() => _RiderRegisterState();
}

class _RiderRegisterState extends State<RiderRegisterPage> {
  File? _image;

  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final imageTemporary = File(image.path);

    setState(() {
      this._image = imageTemporary;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 20, top: 20),
      child: Expanded(
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
            GestureDetector(
              onTap: () {
                getImage();
              },
              child: Image.network(
                'https://i.redd.it/lo49om2517pa1.png',
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Image.network(
              'https://i.redd.it/lo49om2517pa1.png',
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 15,
            ),
            Image.network(
              'https://i.redd.it/lo49om2517pa1.png',
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            )
          ],
        ),
      ),
    );
  }
}
