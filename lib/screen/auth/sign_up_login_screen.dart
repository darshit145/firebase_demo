import 'package:firebase/screen/auth/fatch_data_firebase.dart';
import 'package:firebase/screen/auth/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase/utility/customPackage/custom_class.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  logIn(String mail, String pass) async {
    if (mail == "" && pass == "") {
      CustomAlert.alertDialog(context, "Please enter the fields");
    } else {
      UserCredential? userCreadential;
      try {
        userCreadential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: mail, password: pass)
            .then((value) {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return FatchDataScreen();
            },
          ));
        });
      } on FirebaseAuthException catch (ex) {
        CustomAlert.alertDialog(context, ex.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 250,
              ),
              customTextField(controller: emailController, labelText: "E-Mail"),
              SizedBox(
                height: 20,
              ),
              customTextField(
                  controller: passwordController, labelText: "Password"),
              SizedBox(
                height: 30,
              ),
              customMaterialButtonWidget2(
                  content: Text(
                    "Log in",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    logIn(emailController.text.toString(),
                        passwordController.text.toString());
                  }),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already Have an Account?",
                    style: TextStyle(fontSize: 12),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return SignupScreen();
                          },
                        ));
                      },
                      child: Text(
                        "Sign up",
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return ReserPassword();
                      },
                    ));
                  },
                  child: Text(
                    "Reset Password?",
                    style: TextStyle(color: Colors.blue),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void signUp(String mail, String pass) async {
    if (mail == "" && pass == "") {
      CustomAlert.alertDialog(context, "Enter Required Fields");
    } else {
      UserCredential? usercredential;
      try {
        usercredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: mail, password: pass)
            .then((value) {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return FatchDataScreen();
            },
          ));
        });
      } on FirebaseAuthException catch (exception) {
        return CustomAlert.alertDialog(context, "$mail,\n$pass");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Sign Up "),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customTextField(controller: emailController, labelText: "E-Mail"),
            SizedBox(
              height: 20,
            ),
            customTextField(
                controller: passwordController, labelText: "Password"),
            SizedBox(
              height: 30,
            ),
            customMaterialButtonWidget2(
                content: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  signUp(emailController.text.toString(),
                      passwordController.text.toString());
                }),
          ],
        ),
      ),
    );
  }
}
