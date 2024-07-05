import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase/utility/customPackage/custom_class.dart';

class DemoMap extends StatefulWidget {
  const DemoMap({super.key});

  @override
  State<DemoMap> createState() => _GoogleSearchPlacesState();
}

class _GoogleSearchPlacesState extends State<DemoMap> {
  List<dynamic> _placesList = [];
  TextEditingController _textEditingController = TextEditingController();
  var uuid = Uuid();
  String sectionId = "12332";

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      afterListenerCalled();
    });
  }

  afterListenerCalled() {
    if (sectionId == null) {
      setState(() {
        sectionId = uuid.v4();
      });
    }
    getLocationSuggestion(_textEditingController.text);
  }

  getLocationSuggestion(String text) async {
    String URL = 'https://nominatim.openstreetmap.org/search?q=$text&format=json&addressdetails=1';
    var response = await http.get(Uri.parse(URL));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());
      if (data is List && data.isNotEmpty) {
        print(response.body);
        setState(() {
          _placesList = data;
        });
        print("ok");
      } else {
        setState(() {
          _placesList = [];
        });
      }
    } else {
      print("____________________________");
      throw Exception("Failed to load data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Places"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            customTextField(controller: _textEditingController, labelText: "Enter Location to search"),
            Expanded(
              child: ListView.builder(
                itemCount: _placesList.length,
                itemBuilder: (context, index) {
                  final place = _placesList[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      style: ListTileStyle.list,
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                      title: Text(place['display_name']),
                      subtitle: Text(place['lat'].toString()+place['lon'].toString()),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

