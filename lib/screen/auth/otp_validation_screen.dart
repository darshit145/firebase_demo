import 'package:firebase/utility/customPackage/custom_class.dart';
import 'package:firebase/screen/auth/home_screen.dart';
import 'package:firebase/screen/auth/phone_validation_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OtpValidationScreen extends StatefulWidget {
  String varificationId;
  OtpValidationScreen({super.key, required this.varificationId});

  @override
  State<OtpValidationScreen> createState() =>
      _OtpValidationScreenState(varificationId);
}

class _OtpValidationScreenState extends State<OtpValidationScreen> {
  String varificationId;
  _OtpValidationScreenState(this.varificationId);
  TextEditingController OTPcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Enter OTP"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("We send OTP to:",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
            Text(
              "${phoneNumberController.text}",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 20,
            ),
            customTextField(
                controller: OTPcontroller,
                labelText: "Enter OTP",
                keybosrdType: TextInputType.phone),
            SizedBox(
              height: 30,
            ),
            Center(
                child: customMaterialButtonWidget2(
                    content: Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () async {
                      try {
                        PhoneAuthCredential creadintial =
                            PhoneAuthProvider.credential(
                                verificationId: varificationId,
                                smsCode: OTPcontroller.text.toString());
                        FirebaseAuth.instance
                            .signInWithCredential(creadintial)
                            .then((value) {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return HomePageScreen();
                            },
                          ));
                        });
                      } catch (ex) {
                        // log(ex.toString());
                      }
                    }))
          ],
        ),
      ),
    );
  }
}
