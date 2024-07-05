import 'dart:async';
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart'as dd;
import 'package:geolocator/geolocator.dart' as geo;
import 'package:firebase/utility/customPackage/custom_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
class GoogleSearchPlaces extends StatefulWidget {
  const GoogleSearchPlaces({super.key});

  @override
  State<GoogleSearchPlaces> createState() => _GoogleSearchPlacesState();
}

class _GoogleSearchPlacesState extends State<GoogleSearchPlaces> {
  var uuid=Uuid();
  TextEditingController _textEditingController=TextEditingController();
  List<dynamic> _listForLocation=[];
  String sectionId="12312";
  @override
  void initState(){
    super.initState();
    _textEditingController.addListener(() {
      afterListenerCalled();
    },);
  }
  afterListenerCalled()async{
    if(sectionId==null){
      sectionId=uuid.v4();
    }
    fatchLocation(_textEditingController.text);

  }
  fatchLocation(String location)async{
    final String URL = 'https://nominatim.openstreetmap.org/search?q=$location&format=json&addressdetails=1';
    var responce=await http.get(Uri.parse(URL));
    if(responce.statusCode==200){
      final data=jsonDecode(responce.body.toString());
      if(data.isNotEmpty && data is List){
        setState(() {
          _listForLocation=data;
          print(data);

        });
      }else{
        _listForLocation=[];
      }
    }else{
      print("ERRorRRRRRRRRRRRRRR");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Google Map Search"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            customTextField(controller: _textEditingController, labelText: "Enter Place That You Want to go"),
            Expanded(child: ListView.builder(itemBuilder: (context, index) {
              var  suggestedLocation=_listForLocation[index];
              return Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(6))
                  ),
                  child: ListTile(
                      onTap: () {
                        List<dd.Marker> _markers=[
                          dd.Marker(markerId: dd.MarkerId("1"),
                              position: dd.LatLng(double.parse(suggestedLocation['lat']),double.parse(suggestedLocation['lon'])),
                            infoWindow: dd.InfoWindow(title: "${_textEditingController.text}")
                          )
                        ];
                  
                        final dd.CameraPosition _cameraposition=dd.CameraPosition(target: dd.LatLng(double.parse(suggestedLocation['lat']),double.parse(suggestedLocation['lon'])),zoom: 14 );
                        final laterlonger=dd.LatLng(double.parse(suggestedLocation['lat']),double.parse(suggestedLocation['lon']));
                  
                  
                        Navigator.push(context, MaterialPageRoute(builder: (context) => GoogleEartha(cameraposition: _cameraposition,markers: _markers,laterlonger: laterlonger,),));
                      },

                      title: Text(suggestedLocation['display_name']),
                      subtitle: Text("Lat:${suggestedLocation['lat']} Lon:${suggestedLocation['lon']}")
                  
                  ),
                ),
              );
            },itemCount: _listForLocation.length,))
          ],
        ),
      ),
    );
  }
}
bool toggleSwitch=true;
class GoogleEartha extends StatefulWidget {
  final dd.CameraPosition cameraposition;
  final markers;
  final laterlonger;


  GoogleEartha({required this.laterlonger ,required this.cameraposition,required this.markers});

  @override
  State<GoogleEartha> createState() => _GoogleEarthaState(markers:markers ,laterlonger: laterlonger,cameraposition: cameraposition);
}

class _GoogleEarthaState extends State<GoogleEartha> {
  final dd.CameraPosition cameraposition;
  final  markers;
  final Set<dd.Polyline>_polyline={};
  final laterlonger;



  _GoogleEarthaState({required this.laterlonger,required this. markers,required this.cameraposition});
  void initState(){
    super.initState();
caller();
  }
caller()async{
    var r= await  geo.Geolocator.getCurrentPosition();
    setState(() {
      markers.add(
          dd.Marker(markerId: dd.MarkerId("2"),
              position: dd.LatLng(r.latitude,r.longitude)
          )
      );


    });

}

  Completer<dd.GoogleMapController> _completer=Completer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  SizedBox(
          child: dd.GoogleMap(
            polylines: _polyline,
            initialCameraPosition:  cameraposition,
            mapType: dd.MapType.hybrid,
            myLocationEnabled: true,
            compassEnabled: true,
            markers: Set.of( markers),
            onMapCreated: (dd.GoogleMapController controller) {
              _completer.complete(controller);
            },
          ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          var r= await  geo.Geolocator.getCurrentPosition();

          setState(() {
            _polyline.add(
                dd.Polyline(
                    polylineId: dd.PolylineId("22"),
                    points: [dd.LatLng(r.latitude, r.longitude),laterlonger ]
                )
            );

          });

        },child: Icon(Icons.add),
      ),
    );
  }
}

