import 'dart:async';

import 'package:firebase/utility/customPackage/custom_class.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LoginSignupWithsharedpreerances extends StatefulWidget {
  const LoginSignupWithsharedpreerances({super.key});

  @override
  State<LoginSignupWithsharedpreerances> createState() => _LoginSignupWithsharedpreerancesState();
}
late bool isLogined;
class _LoginSignupWithsharedpreerancesState extends State<LoginSignupWithsharedpreerances> {
  static const keylogin="login";
  @override
  void initState(){
    super.initState();
    navigate();
  }
  void navigate()async{
    var sharedPref=await SharedPreferences.getInstance();
    isLogined= sharedPref.getBool(keylogin)??true;


    Timer(Duration(seconds: 1),(){
      if(isLogined){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SharedPrefLoginScreen(),));
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AfterLoginScreen(),));

      }

    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("SharedPreferance"),
      ),
      body: Container(
        color: Colors.red.shade50,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
class SharedPrefLoginScreen extends StatefulWidget {
  const SharedPrefLoginScreen({super.key});

  @override
  State<SharedPrefLoginScreen> createState() => _SharedPrefLoginScreenState();
}

class _SharedPrefLoginScreenState extends State<SharedPrefLoginScreen> {
  TextEditingController controller= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("SharedPreferance"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: CircleAvatar(radius: 90,),),
            SizedBox(height: 20,),
            Center(child: customTextField(controller: controller, labelText: "Enter Mail"),),
            SizedBox(height: 20,),

            Center(child: customTextField(controller: controller, labelText: "Enter Pass"),),
            SizedBox(height: 20,),


            Center(child: customMaterialButtonWidget2(content: Text("Confirm",style: TextStyle(color: Colors.white),), onTap:()async  {
              var sharedPref=await SharedPreferences.getInstance();
              sharedPref.setBool(_LoginSignupWithsharedpreerancesState.keylogin, false);
              Navigator.push(context, MaterialPageRoute(builder: (context) => AfterLoginScreen(),));
            }))

          ],
        ),
      ),
    );
  }

}
class AfterLoginScreen extends StatefulWidget {
  const AfterLoginScreen({super.key});

  @override
  State<AfterLoginScreen> createState() => _AfterLoginScreenState();
}

class _AfterLoginScreenState extends State<AfterLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Wona Log Out-> "),
        actions: [
          IconButton(onPressed: ()async{
            var sp=await SharedPreferences.getInstance();
            sp.setBool(_LoginSignupWithsharedpreerancesState.keylogin, true);
            // isLogined=false;
            Navigator.pop(context);
          }, icon: Icon(Icons.exit_to_app_sharp))
        ],
      ),
      body: Center(
        child: Text("Congrates! U'r loged in"),
      ),
    );
  }
}
