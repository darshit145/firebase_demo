import 'package:firebase/utility/customPackage/custom_class.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreScreen extends StatefulWidget {
  const SharedPreScreen({super.key});

  @override
  State<SharedPreScreen> createState() => _SharedPreScreenState();
}

String nameValue = "No vallue Saved";

class _SharedPreScreenState extends State<SharedPreScreen> {
  void initState() {
    super.initState();
    calSharedPrefFunction();
  }

  TextEditingController controller = TextEditingController(text: "$nameValue");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SharedPreScreen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customTextField(controller: controller, labelText: "Save"),
            const SizedBox(
              height: 20,
            ),
            customMaterialButtonWidget2(
                content: const Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () async {
                  String name = controller.text.toString();
                  var sharedPreferances = await SharedPreferences.getInstance();
                  sharedPreferances.setString("name", name);
                  // sharedPreferances.remove("name");
                }),
            const SizedBox(
              height: 20,
            ),
            Text(nameValue),
          ],
        ),
      ),
    );
  }

  void calSharedPrefFunction() async {
    var sharedPrefeerances = await SharedPreferences.getInstance();
    setState(() {
      nameValue = sharedPrefeerances.getString("name") ?? nameValue;
    });
  }
}
