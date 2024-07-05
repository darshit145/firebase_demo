import 'package:firebase/screen/mapapi/adding_custom_marcker.dart';
import 'package:firebase/screen/mapapi/address_from_map.dart';
import 'package:firebase/screen/mapapi/demo_map.dart';
import 'package:firebase/screen/mapapi/first_map_api_screen.dart';
import 'package:firebase/screen/mapapi/get_userlocation_with_marcker.dart';
import 'package:firebase/screen/mapapi/google_map_polygen.dart';
import 'package:firebase/screen/mapapi/google_search_places.dart';
import 'package:firebase/screen/mapapi/google_map_theme.dart';
import 'package:firebase/utility/customPackage/custom_class.dart';
import 'package:flutter/material.dart';
class GoogleMap extends StatefulWidget {
  const GoogleMap({super.key});

  @override
  State<GoogleMap> createState() => _GoogleMapState();
}

class _GoogleMapState extends State<GoogleMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Map"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Marker"),
            customMaterialButtonWidget2(width: 220,content: Text("Google Map \nWith Marcker",style: TextStyle(color: Colors.white),), onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FirstMapApiScreen(),));
            },),
            customMaterialButtonWidget2(width: 220,content: Text(" Cordinate to Adderss\n Address to cordinate ",style: TextStyle(color: Colors.white),), onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddressFromMap(),));
            },),
           customMaterialButtonWidget2(width: 220,content: Text("Getting User Location ",style: TextStyle(color: Colors.white),), onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  GetUserlocationWithMarcker(),));
            },),
            customMaterialButtonWidget2(width: 220,content: Text("Google map Places",style: TextStyle(color: Colors.white),), onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  GoogleSearchPlaces(),));
            },),
            customMaterialButtonWidget2(width: 220,content: Text("Custom Marckers",style: TextStyle(color: Colors.white),), onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddingCustomMarcker(),));
            },),
            customMaterialButtonWidget2(width: 220,content: Text("GoogleMap Polygon",style: TextStyle(color: Colors.white),), onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  GoogleMapPolygen(),));
            },),
            customMaterialButtonWidget2(width: 220,content: Text("GoogleMap Theme",style: TextStyle(color: Colors.white),), onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  GoogleMapTheme(),));
            },),
            customMaterialButtonWidget2(width: 220,content: Text("DEMO",style: TextStyle(color: Colors.white),), onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  DemoMap(),));
            },),
          ],
        ),
      ),
    );
  }
}
