import 'package:firebase/screen/auth/check_users.dart';
import 'package:firebase/screen/auth/fatch_data_firebase.dart';
import 'package:firebase/screen/auth/file_store_inFirebase.dart';
import 'package:firebase/screen/auth/google_sign_up_screen.dart';
import 'package:firebase/screen/auth/phone_validation_screen.dart';
import 'package:firebase/screen/mapapi/google_map.dart';
import 'package:firebase/screen/notification/api/notification_page.dart';
import 'package:firebase/utility/customPackage/custom_class.dart';
import 'package:firebase/screen/sqflite_package/sqflite_data_showingscreen.dart';

import 'package:firebase/screen/sharedpreferance/image_pick_sharedpreferance.dart';
import 'package:firebase/screen/sharedpreferance/shadepreferance.dart';
import 'package:firebase/screen/sharedpreferance/shared_preferances_withlist.dart';
import 'package:firebase/screen/sharedpreferance/login_signup_withsharedpreerances.dart';
import 'package:firebase/screen/mapapi/first_map_api_screen.dart';
// import 'package:firebase/sql_lite/todo_list.dart';
import 'package:flutter/material.dart';

import '../notification/notification_screen.dart';
class FirstScreenButton extends StatefulWidget {
  const FirstScreenButton({super.key});
  static const route='/notification-screen';

  @override
  State<FirstScreenButton> createState() => _FirstScreenButtonState();
}

class _FirstScreenButtonState extends State<FirstScreenButton> {
  @override
  Widget build(BuildContext context) {
    final message=ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Home_page"),
      ),
      body:Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(message.toString()),
              Text("Sign Up"),
              customMaterialButtonWidget2(width: 250, content: Text("Login/SignUp Screen",style: TextStyle(color: Colors.white),), onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => CheckUser(),));
          
              }),
              customMaterialButtonWidget2(width: 250,content: Text("Sign Up With Google",style: TextStyle(color: Colors.white),), onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  GoogleSignUpScreen(),));
          
              }),
              customMaterialButtonWidget2(width: 250,content: Text("Fatching Data From\nFirebase FireStore",style: TextStyle(color: Colors.white),), onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => FatchDataScreen(),));
          
              }),
              customMaterialButtonWidget2(width: 250,content: Text("Phonr Number Varification\nusing OTP",style: TextStyle(color: Colors.white),), onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => PhoneNumberVarification(),));
          
              }),
              customMaterialButtonWidget2(width: 250,content: Text("File Store in \nStorage",style: TextStyle(color: Colors.white),), onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => FileStore(),));
              }),
              customMaterialButtonWidget2(width: 250,content: Text("ImagePickerDemo",style: TextStyle(color: Colors.white),), onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ImagePickerDeom(),));
              }),
              customMaterialButtonWidget2(width: 250,content: Text("SharedPreferances Demo",style: TextStyle(color: Colors.white),), onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => SharedPreScreen(),));
              }),
              Text("Login With The help of Shared\nPreferances "),
              customMaterialButtonWidget2(width: 250,content: Text("SharedPreferances With \n  SharedPreferance",style: TextStyle(color: Colors.white),), onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginSignupWithsharedpreerances(),));
              }),
              customMaterialButtonWidget2(width: 250,content: Text("SharedPreferances With \n  List",style: TextStyle(color: Colors.white),), onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => SharedPreferancesWithlist(),));
              }),
              customMaterialButtonWidget2(width: 250,content: Text("Imge Picking and Save \nin local storage",style: TextStyle(color: Colors.white),), onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ImagePickSharedpreferance(),));
              }),
              customMaterialButtonWidget2(width: 250,content: Text("Todo List",style: TextStyle(color: Colors.white),), onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenNothing(),));
              }),
              customMaterialButtonWidget2(width: 250,content: Text("Let's GO TO Map",style: TextStyle(color: Colors.white),), onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => GoogleMap(),));
              }),
              customMaterialButtonWidget2(width: 250,content: Text("Firebase Massaging",style: TextStyle(color: Colors.white),), onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage(),));
              }),
            ],
          ),
        ),
      ) ,
    );
  }
}