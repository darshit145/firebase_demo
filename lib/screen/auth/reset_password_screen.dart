import 'package:firebase/utility/customPackage/custom_class.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class ReserPassword extends StatefulWidget {
  const ReserPassword({super.key});

  @override
  State<ReserPassword> createState() => _ReserPasswordState();
}

class _ReserPasswordState extends State<ReserPassword> {
  TextEditingController mailTextController=TextEditingController();
  resetPassWord(String mail)async{
    if(mail==""){
      CustomAlert.alertDialog(context, "Please Enter Mail");
    }else{
      FirebaseAuth.instance.sendPasswordResetEmail(email: mail);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Reset Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(

          children: [
            customTextField(controller: mailTextController, labelText: "Reset PassWord"),
            SizedBox(height: 20,),
            customMaterialButtonWidget2(content: Text("Reset",style: TextStyle(color: Colors.white),), onTap: (){
              resetPassWord(mailTextController.text.toString());
            })
          ],

        ),
      ),
    );
  }
}
