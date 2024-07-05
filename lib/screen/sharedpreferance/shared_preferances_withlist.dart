import 'package:firebase/utility/customPackage/custom_class.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SharedPreferancesWithlist extends StatefulWidget {
  const SharedPreferancesWithlist({super.key});

  @override
  State<SharedPreferancesWithlist> createState() => _SharedPreferancesWithlistState();
}
String aKeyForList="key";
List<String> contactDetails=[];
class _SharedPreferancesWithlistState extends State<SharedPreferancesWithlist> {
  @override
  void initState(){
    super.initState();
    dispenser();
  }
  dispenser()async{
    var setPreferance=await SharedPreferences.getInstance();
    contactDetails= setPreferance.getStringList(aKeyForList)??[];
    // contactDetails=
  }
  TextEditingController phoneController=TextEditingController();
  TextEditingController nameController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wona See Contact->"),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => ContactDetailsScreen(),));
          }, icon: Icon(Icons.contacts))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            customTextField(controller: phoneController, labelText: "Phone",keybosrdType: TextInputType.number),
            SizedBox(height: 20,),
            customTextField(controller: nameController, labelText: "Name",),
            SizedBox(height: 20,),
            customMaterialButtonWidget2(content: Text("Add +",style: TextStyle(color: Colors.white),), onTap: ()async{
              var sharedpreferances=await SharedPreferences.getInstance();
              contactDetails.add("${phoneController.text.toString()} : ${nameController.text.toString()}");
              sharedpreferances.setStringList(aKeyForList, contactDetails);

            })


          ],
        ),
      ),
    );
  }
}
class ContactDetailsScreen extends StatefulWidget {
  const ContactDetailsScreen({super.key});

  @override
  State<ContactDetailsScreen> createState() => _ContactDetailsScreenState();
}

class _ContactDetailsScreenState extends State<ContactDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Your Contact"),
      ),
      body: ListView.builder(
        itemCount: contactDetails.length,
        itemBuilder: (context, index) {
          int indexForString=contactDetails[index].indexOf(":");
          print("${contactDetails[index].substring(0,(indexForString-1))}>>>>>>>>>>>>>>>>>>");
        return ListTile(
          leading: CircleAvatar(radius: 20,),
          title: Text(contactDetails[index].substring(indexForString+1).trim()),
          subtitle: Text(contactDetails[index].substring(0,(indexForString-1)).trim()),
        );
      },),
    );
  }
}
