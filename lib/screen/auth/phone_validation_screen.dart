import 'package:firebase/utility/customPackage/custom_class.dart';
import 'package:firebase/screen/auth/sign_up_login_screen.dart';
import 'package:firebase/screen/auth/otp_validation_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhoneNumberVarification extends StatefulWidget {
  const PhoneNumberVarification({super.key});

  @override
  State<PhoneNumberVarification> createState() =>
      _PhoneNumberVerificationState();
}

TextEditingController phoneNumberController = TextEditingController();

class _PhoneNumberVerificationState extends State<PhoneNumberVarification> {
  String? _verificationId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("PhoneNumber Verification Page"),
        actions: [
          IconButton(
              onPressed: () {
                logOutUser();
              },
              icon: Icon(Icons.exit_to_app_sharp))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customTextField(
                controller: phoneNumberController,
                labelText: "Enter Phone Number",
                // keyboardType: TextInputType.phone
                keybosrdType: TextInputType.number),
            SizedBox(
              height: 20,
            ),
            customMaterialButtonWidget2(
              content: Text(
                "Verify",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () async {
                await FirebaseAuth.instance.verifyPhoneNumber(
                  phoneNumber: "+91${phoneNumberController.text}",
                    verificationCompleted: (PhoneAuthCredential creadintial) {},
                    verificationFailed: (FirebaseAuthException ex) {},
                    codeSent: (String varificationId, int? no) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return OtpValidationScreen(varificationId: varificationId);
                    },));
                    },
                    codeAutoRetrievalTimeout: (String varificationId) {});
              },
            )
          ],
        ),
      ),
    );
  }

  logOutUser() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return LogInScreen();
      },
    ));
  }
}
