import 'dart:developer';
import 'package:firebase/utility/customPackage/custom_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/screen/sharedpreferance/shadepreferance.dart';

class FileStore extends StatefulWidget {
  const FileStore({super.key});

  @override
  State<FileStore> createState() => _FileStoreState();
}

class _FileStoreState extends State<FileStore> {
  TextEditingController myController = TextEditingController();
  TextEditingController myController1 = TextEditingController();
  File? imagePicked;
  signUp(String mail, String pass) async {
    if (imagePicked == null && mail == null && pass == null) {
      CustomAlert.alertDialog(context, "Enter Required Fields");
    } else {
      UserCredential? creadintial;
      try {
        creadintial = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: mail, password: pass)
            .then((value) {
          uploadData();
        });
      } on FirebaseAuthException catch (ex) {
        log(ex.code.toString());
      }
    }
  }

  uploadData() async {
    UploadTask up = FirebaseStorage.instance
        .ref("Profile pic")
        .child(myController.text.toString())
        .putFile(imagePicked!);
    TaskSnapshot anapSot = await up;
    String url = await anapSot.ref.getDownloadURL();
    FirebaseFirestore.instance
        .collection("Users")
        .doc(myController.text.toString())
        .set({
      "Gmail": myController.text.toString(),
      "Image": url,
      "pass": myController1.text.toString(),
    }).then((value) {
      log("OK>>>>>>>>>>>>>");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FileStore"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            GestureDetector(
                onTap: () {
                  CustomAlert.alertDialogCustom(
                      context,
                      "Pick Img",
                      SizedBox(
                        height: 150,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text("Camera"),
                              onTap: () {
                                imagePick(ImageSource.camera);
                                Navigator.pop(context);
                              },
                              leading: Icon(Icons.camera_alt_outlined),
                            ),
                            ListTile(
                              onTap: () {
                                imagePick(ImageSource.gallery);
                                Navigator.pop(context);
                              },
                              title: Text("Gallary"),
                              leading: Icon(Icons.photo),
                            )
                          ],
                        ),
                      ));
                },
                child: imagePicked == null
                    ? CircleAvatar(
                        radius: 60,
                        child: Icon(
                          Icons.person,
                          size: 70,
                        ),
                      )
                    : CircleAvatar(
                        radius: 60,
                        backgroundImage: FileImage(imagePicked!),
                      )),
            SizedBox(
              height: 20,
            ),
            customTextField(controller: myController, labelText: "Mail"),
            SizedBox(
              height: 20,
            ),
            customTextField(controller: myController1, labelText: "Pass"),
            SizedBox(
              height: 20,
            ),
            customMaterialButtonWidget2(
                content: Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () async {
                  await signUp(myController.text.toString(),
                      myController1.text.toString());
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImagePickerDeom(),
                      ));
                })
          ],
        ),
      ),
    );
  }

  imagePick(ImageSource imgs) async {
    try {
      final image = await ImagePicker().pickImage(source: imgs);
      if (image == null) return;
      final imagePath = File(image.path);
      setState(() {
        imagePicked = imagePath;
      });
    } catch (ex) {
      log(ex.toString());
    }
  }
}

class ImagePickerDeom extends StatefulWidget {
  const ImagePickerDeom({super.key});

  @override
  State<ImagePickerDeom> createState() => _ImagePickerDeomState();
}

class _ImagePickerDeomState extends State<ImagePickerDeom> {
  File? ok;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return SharedPreScreen();
            },));
          }, child: Text("Go next"))
        ],
      ),
      body: Center(
        child: GestureDetector(
            onTap: () {
              CustomAlert.alertDialogCustom(
                  context,
                  "ok",
                  SizedBox(
                      height: 150,
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () {
                              img(ImageSource.camera);
                              Navigator.pop(context);
                            },
                            leading: Icon(Icons.camera),
                          ),
                          ListTile(
                            onTap: () {
                              img(ImageSource.gallery);
                              Navigator.pop(context);

                            },
                            leading: Icon(Icons.photo),
                          )
                        ],
                      )));
            },
            child: ok == null
                ? CircleAvatar(
                    radius: 90,
                    child: Icon(
                      Icons.person,
                      size: 90,
                    ),
                  )
                : CircleAvatar(
                    radius: 90,
                    backgroundImage: FileImage(ok!),
                  )),
      ),
    );
  }

  img(ImageSource img) async {
    final picker = await ImagePicker().pickImage(source: img);
    if (picker == null) return;
    final data = File(picker.path);
    setState(() {
      ok = data;
    });
  }
}
