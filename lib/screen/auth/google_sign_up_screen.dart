import 'package:firebase/utility/customPackage/custom_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:flutter/material.dart';
class GoogleSignUpScreen extends StatefulWidget {
  const GoogleSignUpScreen({super.key});

  @override
  State<GoogleSignUpScreen> createState() => _GoogleSignUpScreenState();
}

class _GoogleSignUpScreenState extends State<GoogleSignUpScreen> {
  final FirebaseAuth _auth=FirebaseAuth.instance;
  User? _user;

  @override
  void initState() {
    _auth.authStateChanges().listen((val){
      setState(() {
        _user=val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("GoogleSignUpProcess"),
      ),
      body: _user!=null?userInfo():googleSignButton(),
    );
  }
  Widget googleSignButton(){
    return Center(
      child: Container(
        height: 60,
        // width: 250,
        child: SignInButton(
          onPressed: googleSignHandle,
          text: "Sign Up WIth Google",
          Buttons.anonymous
        ),
      ),
    );
  }
  Widget userInfo(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.red.shade50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              // image: DecorationImage(
              //   image: NetworkImage(_user!.photoURL!)
              // )
            ),
          ),
          Text(_user!.email!),
          Text(_user!.uid),
          customMaterialButtonWidget2(content: Text("Sign Out",style: TextStyle(color: Colors.white),), onTap: _auth.signOut)
        ],
      ),
    );
  }
  void googleSignHandle(){
    try{
      GoogleAuthProvider _provider=GoogleAuthProvider();
      _auth.signInWithProvider(_provider);
    }catch (c){

    }
  }
}
