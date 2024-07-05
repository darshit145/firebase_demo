import 'dart:async';
import 'package:firebase/utility/map/map_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapTheme extends StatefulWidget {
  const GoogleMapTheme({super.key});

  @override
  State<GoogleMapTheme> createState() => _GoogleMapThemeState();
}

class _GoogleMapThemeState extends State<GoogleMapTheme> {
  final Completer<GoogleMapController> _controllerCompleter = Completer();
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Google Map"),
        actions: [
          IconButton(
            onPressed: _toggleMapStyle,
            icon: Icon(Icons.three_g_mobiledata_sharp),
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: LatLng(22, 70), zoom: 10),
        onMapCreated: (controller) {
          _controllerCompleter.complete(controller);
          _setMapStyle(controller);
        },
      ),
    );
  }

  Future<void> _toggleMapStyle() async {
    final controller = await _controllerCompleter.future;
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
    _setMapStyle(controller);
  }

  Future<void> _setMapStyle(GoogleMapController controller) async {
    if (_isDarkMode) {
      await controller.setMapStyle(MapTheme.mapStyle);
    } else {
      await controller.setMapStyle(MapTheme.mapStyle2);
    }
  }
}
