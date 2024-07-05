import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
class GetUserlocationWithMarcker extends StatefulWidget {
  const GetUserlocationWithMarcker({super.key});

  @override
  State<GetUserlocationWithMarcker> createState() => _GetUserlocationWithMarckerState();
}

class _GetUserlocationWithMarckerState extends State<GetUserlocationWithMarcker> {
  List<double> latLong=[];
  List<Marker> _markers=[
    Marker(markerId: MarkerId("1"),position: LatLng(22.314648, 70.766785 ),infoWindow: InfoWindow(title: "My position")),
  ];
  Completer<GoogleMapController> _completer=Completer();
  final CameraPosition _cameraPosition =const CameraPosition(target: LatLng(22.314648, 70.766785 ),zoom: 16.0,tilt: 0,bearing: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _cameraPosition,
          mapType: MapType.terrain,
          myLocationEnabled: true,
          compassEnabled: true,
          markers: Set.of(_markers),
          onMapCreated: (GoogleMapController controller) {
            _completer.complete(controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_searching_sharp),

        onPressed: () async{
          getUserCurrentLocation().then((value)async{
            latLong.add(value.longitude);
            latLong.add(value.latitude);

            CameraPosition _cameraPosition=CameraPosition(target: LatLng(value.latitude,value.longitude),zoom: 15,);
            final GoogleMapController _controller=await _completer.future;
            _controller.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));



            setState(() {
              _markers.add(
                  Marker(markerId: MarkerId("2"),
                      position: LatLng(value.latitude,value.longitude),
                      infoWindow: InfoWindow(
                          title: "My Current Location"
                      )
                  )
              );

            });
          }).onError((a,s){print("Error frombutton");});


        },
      ),
    );
  }
  Future<Position> getUserCurrentLocation()async{
    await Geolocator.requestPermission().then((value){}).onError((error,r){print(error.toString());});
    return await Geolocator.getCurrentPosition();
  }
}
