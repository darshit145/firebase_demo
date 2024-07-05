import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class FirstMapApiScreen extends StatefulWidget {
  const FirstMapApiScreen({super.key});

  @override
  State<FirstMapApiScreen> createState() => _FirstMapApiScreenState();
}

class _FirstMapApiScreenState extends State<FirstMapApiScreen> {
  List<Marker> _listMarker=[];
  List<Marker> _marker=[
    Marker(markerId: MarkerId("1"),
      position: LatLng(22.314648, 70.766785 ),
      infoWindow: InfoWindow(
        title: "My position"
      )
    ),
    Marker(markerId: MarkerId("2"),
      position: LatLng(22.3648, 70.7667 ),
      infoWindow: InfoWindow(
        title: "New Jercy"
      )
    ),
  ];
  Completer<GoogleMapController> _completer=Completer();
  final CameraPosition _cameraPosition =  const CameraPosition(target: LatLng(22.314648, 70.766785 ),zoom: 16.0, tilt: 0, );
  @override
  void initState() {
    _listMarker.addAll(_marker);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _cameraPosition,
          mapType: MapType.terrain,
          myLocationEnabled: true,
          compassEnabled: true,

          markers: Set.of(_listMarker),
        
          onMapCreated: (GoogleMapController controller) {
            _completer.complete(controller);
          },
        
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_searching_sharp),
        onPressed: () async{
          GoogleMapController _googleMapController=await _completer.future;
          _googleMapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(target: LatLng(22.3648, 70.7667),
                zoom: 14,
                tilt: 10
              )
            )
          );setState(() {});

        },
      ),
    );
  }
}
