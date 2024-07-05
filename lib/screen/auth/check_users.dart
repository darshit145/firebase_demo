import 'package:firebase/screen/auth/fatch_data_firebase.dart';
import 'package:firebase/screen/auth/sign_up_login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase/screen/auth/phone_validation_screen.dart';
class CheckUser extends StatefulWidget {
  const CheckUser({super.key});

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  @override
  Widget build(BuildContext context) {
    return checkUser();
  }
  checkUser(){
    final user=FirebaseAuth.instance.currentUser;
    if(user!=null){
      return FatchDataScreen();
    }else{
      return LogInScreen();
    }
  }
}
