import 'package:firebase/screen/sqflite_package/sqlflite_select_screen.dart';
import 'package:firebase/utility/customPackage/custom_class.dart';
import 'package:firebase/screen/sharedpreferance/shadepreferance.dart';
import 'package:flutter/material.dart';
import 'package:firebase/screen/sqflite_package/subject.dart';
import 'package:firebase/screen/sqflite_package/database_services.dart';

var subjectToUpdate = null;

class ScreenNothing extends StatefulWidget {
  const ScreenNothing({super.key});

  @override
  State<ScreenNothing> createState() => _ScreenNothingState();
}

class _ScreenNothingState extends State<ScreenNothing> {
  final DatabaseServices _databaseServices = DatabaseServices();
  TextEditingController controllerForName = TextEditingController();
  TextEditingController controllerFroAge = TextEditingController();


  Future<List<Subject>> _getAllRecords() async {
    final records = await _databaseServices.fatchRecords();
    return records.map((record) => Subject.fromMap(record)).toList();
  }
  int data=0;
  bool b=true;
  displayer(int t){
    data=data+t;
  }
  _addRecords() {
    displayer(1);
    final name = controllerForName.text.toString();
    final age = int.tryParse(controllerFroAge.text) ?? 0;
    if (name == "" || controllerFroAge.text == null) {
      return;
    }
    Subject subject = Subject(name: name, age: age!);
    _databaseServices.insertRecords(subject.toMap());
    controllerFroAge.clear();
    controllerForName.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => SqlfliteSelectScreen(),));
          }, icon: Icon(Icons.navigate_next_rounded))
        ],
        title: Text("Database Data"),
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: customMaterialButtonWidget2(
              content: Text("Save", style: TextStyle(color: Colors.white)),
              onTap: _addRecords,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: customMaterialButtonWidget2(
              content: Text("Update", style: TextStyle(color: Colors.white)),
              onTap: () async {
                // Assuming you have a way to get the Subject to update
                _updateRecord(subjectToUpdate);
              },
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async{
          b=false;
          setState(() {

          });
        },
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  customTextField(
                      controller: controllerForName, labelText: "Enter Name"),
                  SizedBox(height: 20),
                  customTextField(
                      controller: controllerFroAge,
                      labelText: "Enter Age",
                      keybosrdType: TextInputType.number),
                  SizedBox(height: 10),
                ],
              ),
            ),
            Text("$data"),
            Expanded(
              child: FutureBuilder<List<Subject>>(
                future: _getAllRecords(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    final people = snapshot.data!;

                    return ListView.builder(
                      itemCount: people.length,
                      itemBuilder: (context, index) {
                        if(b){
                          displayer(1);
                        }
                        if(people[index]==people.last){
                          b=false;
                          print("+++++++++++++++++++++++++++++");


                          // displayer(1);
                        }
                        return ListTile(
                          title: Text(people[index].name),
                          subtitle: Text("Age: ${people[index].age}"),
                          trailing: IconButton(
                            onPressed: () async {
                               _deleteRecord(index,people[index]);
                              const msg = SnackBar(
                                duration: Duration(milliseconds: 100),
                                content: Text("The Item Deleted"),
                              );
                            ScaffoldMessenger.of(context).showSnackBar(msg);
                            },
                            icon: Icon(Icons.delete),
                          ),
                          onTap: () {
                            controllerForName.text = people[index].name;
                            controllerFroAge.text = people[index].age.toString();
                            subjectToUpdate = people[index];
                            // _updateRecord(people[index]);
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateRecord(Subject subject) async {
    subject.name = controllerForName.text;
    subject.age = int.tryParse(controllerFroAge.text) ?? 0;
    if (subject.name.isEmpty || controllerFroAge.text.isEmpty) {
      return;
    }
    await _databaseServices.updateRecord(subject);
    setState(() {});
  }

  //For delteing the all record from the batabase
  Future<void> _deleteRecord(int id,Subject subject) async {
    data=data-1;
    await _databaseServices.deleteRecord(id,subject);
    setState(() {
      print("okkoko");
    });
  }
}
