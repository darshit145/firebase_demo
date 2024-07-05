import 'package:firebase/screen/auth/file_store_inFirebase.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class FatchDataScreen extends StatefulWidget {
  const FatchDataScreen({super.key});

  @override
  State<FatchDataScreen> createState() => _FatchDataScreenState();
}

class _FatchDataScreenState extends State<FatchDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Show Data"),
        actions: [
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => FileStore(),));
          }, child: Text("Press"))
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.active){

            if(snapshot!.hasData){

              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Text("${index+1}"),
                  ),
                  title: Text("${snapshot.data!.docs[index]["pass"]}"),
                  subtitle: Text("${snapshot.data!.docs[index]["Gmail"]}"),
                );
              },);
            }
            else if(snapshot.hasError){

              return Center(child: Text("${snapshot.hasError} Error"),);
            }
            else{
              return Center(child: Text("No Data Found"),);
            }
          }
          else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// class FatchDataScreen extends StatefulWidget {
//   const FatchDataScreen({super.key});
//
//   @override
//   State<FatchDataScreen> createState() => _FatchDataScreenState();
// }
//
// class _FatchDataScreenState extends State<FatchDataScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
