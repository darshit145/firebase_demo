import 'dart:async';
import 'dart:collection';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
class GoogleMapPolygen extends StatefulWidget {
  const GoogleMapPolygen({super.key});

  @override
  State<GoogleMapPolygen> createState() => _GoogleMapPolygenState();
}

class _GoogleMapPolygenState extends State<GoogleMapPolygen> {
  Completer<GoogleMapController> _completer=Completer();
  List<LatLng> _latLong=[
    LatLng(25.0742,55.1885),
    LatLng(25.0742,55.1886),
    LatLng(25.0743,55.1886),
    LatLng(25.0743,55.182),
    LatLng(25.07,55.182),
    LatLng(25.0742,55.1885),

  ];
  Set<Polygon> polygonset=HashSet<Polygon>();
  @override
  void initState(){
    super.initState();
    polygonset.add(
      Polygon(polygonId: PolygonId("ok"),points: _latLong,fillColor: Colors.red.shade50,geodesic: true,strokeWidth: 1)
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        polygons: polygonset,
        initialCameraPosition: CameraPosition(target: LatLng(25.0742,55.1885),zoom: 14),
        onMapCreated: (controller) {
          _completer.complete(controller);
        },
      ),
    );
  }
}
