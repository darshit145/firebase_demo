import 'package:firebase/utility/customPackage/custom_class.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickSharedpreferance extends StatefulWidget {
  const ImagePickSharedpreferance({super.key});

  @override
  State<ImagePickSharedpreferance> createState() =>
      _ImagePickSharedpreferanceState();
}

const String KEYFORIMG = "Keys";

class _ImagePickSharedpreferanceState extends State<ImagePickSharedpreferance> {
  late File? image;
  late String? imagePath;
  @override
  void initState() {
    super.initState();
    image=null;
    loadImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Profile img"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CircleAvatar(
              radius: 70,
              backgroundImage: image != null ? FileImage(image!) : null,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: customMaterialButtonWidget2(
                content: Text(
                  "Add Image +",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  CustomAlert.alertDialogCustom(
                      context,
                      "Select a Way to add img",
                      SizedBox(
                        height: 160,
                        child: Column(
                          children: [
                            ListTile(
                              onTap: () {
                                imagePicker(ImageSource.camera);
                                Navigator.pop(context);
                              },
                              leading: const Icon(Icons.camera),
                              title: Text("Camera"),
                            ),
                            ListTile(
                              onTap: () {
                                imagePicker(ImageSource.gallery);
                                Navigator.pop(context);
                              },
                              leading: Icon(Icons.photo),
                              title: Text("Galary"),
                            )
                          ],
                        ),
                      ));
                }),
          ),
          Center(
            child: customMaterialButtonWidget2(
                content: const Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  image==null?null: saveImage(image!.path);
                }),
          ),
        ],
      ),
    );
  }

  imagePicker(ImageSource source) async {
    final imagePicker = await ImagePicker().pickImage(source: source);
    if (imagePicker == null) return;
    final img = File(imagePicker.path);
    setState(() {
      image = img;
    });
  }

  saveImage(path) async {print("Saving>>>>>>>>>>>>>");
    final preferances = await SharedPreferences.getInstance();
    preferances.setString(KEYFORIMG, path);
  }

  loadImage() async {print("LOading>>>>>>>>>>>>");
    final preferances = await SharedPreferences.getInstance();
    setState(() {
       var r= preferances.getString(KEYFORIMG)??imagePath;
       image=File(r!);

    });

  }
}
