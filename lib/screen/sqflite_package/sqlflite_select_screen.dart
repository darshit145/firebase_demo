import 'package:firebase/screen/sqflite_package/subject.dart';
import 'package:firebase/utility/customPackage/custom_class.dart';
import 'package:flutter/material.dart';
import 'package:firebase/screen/sqflite_package/database_services.dart';

class SqlfliteSelectScreen extends StatefulWidget {
  const SqlfliteSelectScreen({super.key});

  @override
  State<SqlfliteSelectScreen> createState() => _SqlfliteSelectScreenState();
}
List liForData=[false,false,true];
class _SqlfliteSelectScreenState extends State<SqlfliteSelectScreen> {
  final DatabaseServices _databaseServices = DatabaseServices();
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                   liForData=[false,true,false];
                  _fetchPersonsBelow20();
                });
              },
              icon: Icon(Icons.account_balance)),
          IconButton(onPressed: () {
            setState(() {
              liForData=[false,false,true];
            });
          }, icon: Icon(Icons.refresh_sharp))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            customTextField(
                controller: textEditingController, labelText: "Enter name"),
            customMaterialButtonWidget2(
                content: Text(
                  "Search",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  setState(() {
                    liForData=[true,false,false];
                    _getAllSelecttedRecord();
                  });
                }),
            Text(liForData[0]?"Person By Their name" :liForData[1]?"Person Below ${textEditingController.text.toString()}":"Age By Desandinng ORDER"),

            //FOR Searching the records by the Name
            if(liForData[0])
              Expanded(
                child: FutureBuilder(
              future: _getAllSelecttedRecord(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  final person = snapshot.data!;
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      var name = person[index];
                      // print(name.runtimeType);
                      return ListTile(
                        title: Text(name["name"]),
                        subtitle: Text(name["age"].toString()),
                      );
                    },
                    itemCount: person.length,
                  );
                }
              },
            )),
            //FATCh the record BAsed on age
            if(liForData[1])
              Expanded(
                  child: FutureBuilder(
                future: _fetchPersonsBelow20(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    final person = snapshot.data!;
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        var name = person[index];
                        // print(name.runtimeType);
                        return ListTile(
                          title: Text(name["name"]),
                          subtitle: Text(name["age"].toString()),
                        );
                      },
                      itemCount: person.length,
                    );
                  }
                },
              )),
            //For Desanding The Record By age
            if (liForData[2])
              Expanded(
                  child: FutureBuilder(
                future: _futureForAllTheData(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    final person = snapshot.data!;
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        var name = person[index];
                        // print(name.runtimeType);
                        return ListTile(
                          title: Text(name["name"]),
                          subtitle: Text(name["age"].toString()),
                        );
                      },
                      itemCount: person.length,
                    );
                  }
                },
              )),
          ],
        ),
      ),
    );
  }

//FOR Searching the records by the Name
  Future<List<Map<String, dynamic>>?> _getAllSelecttedRecord() async {
    final record = await _databaseServices
        .selectBaseOncondition(textEditingController.text.toString().trim());
    return record;
  }
//FATCh the record BAsed on age
  Future<List<Map<String, dynamic>>?> _fetchPersonsBelow20() async {
    final result = await _databaseServices
        .fetchAllBelowAge(int.tryParse(textEditingController.text) ?? 90);
    return result;
  }

  //For Desanding The Record By age
  Future<List<Map<String, dynamic>>?> _futureForAllTheData() async {
    final record = await _databaseServices.getreverseId(int.tryParse(textEditingController.text)??100);
    return record;
  }
}
