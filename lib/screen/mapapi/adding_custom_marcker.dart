import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:typed_data' as dt;
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class AddingCustomMarcker extends StatefulWidget {
  const AddingCustomMarcker({super.key});

  @override
  State<AddingCustomMarcker> createState() => _AddingCustomMarckerState();
}

class _AddingCustomMarckerState extends State<AddingCustomMarcker> {
  final List<LatLng> latLong = [
    LatLng(25.0742, 55.1885),
    LatLng(25.074, 55.16),
    LatLng(25.0742, 55.186),
    LatLng(25.742, 55.18),
  ];
  List<Marker> _marcker = [];
  CameraPosition _cameraPosition = CameraPosition(target: LatLng(25.0742, 55.1885), zoom: 14);
  Completer<GoogleMapController> _completer = Completer();
  CustomInfoWindowController _customInfoWindowController = CustomInfoWindowController();

  @override
  void initState() {
    super.initState();
    customMarcker();
  }

  Future<void> customMarcker() async {
    for (int i = 0; i < latLong.length; i++) {
      final Uint8List markerIcon = await getImagesFromPortal('https://williamhortonphotography.com/wp-content/uploads/2017/11/ferro-magnetic-fluid-57.jpg'); // Replace with your image URL
      final Codec markerImageCodec = await instantiateImageCodec(
        markerIcon,
        targetHeight: 100,
        targetWidth: 100,
      );
      final FrameInfo frameInfo = await markerImageCodec.getNextFrame();
      final ByteData? byteData = await frameInfo.image.toByteData(
        format: ImageByteFormat.png,
      );
      final Uint8List resizedMarkerIcon = byteData!.buffer.asUint8List();

      _marcker.add(
        Marker(
          markerId: MarkerId("$i"),
          position: latLong[i],
          icon: BitmapDescriptor.fromBytes(resizedMarkerIcon),
          onTap: () {
            _customInfoWindowController.addInfoWindow!(
              Container(
                color: Colors.blueGrey,
                child: Text('Custom Info Window'),
              ),
              latLong[i],
            );
          },
        ),
      );
    }
    setState(() {}); // Update the state to refresh the markers
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _cameraPosition,
            onTap: (argument) {
              _customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position) {
              _customInfoWindowController.onCameraMove!();
            },
            markers: Set.of(_marcker),
            onMapCreated: (controller) {
              _customInfoWindowController.googleMapController = controller;
            },
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 150,
            width: 300,
            offset: 100,
          )
        ],
      ),
    );
  }

  Future<Uint8List> getImagesFromPortal(String path) async {
    final Completer<ImageInfo> completer = Completer<ImageInfo>();
    var img = NetworkImage(path);
    img.resolve(ImageConfiguration()).addListener(
      ImageStreamListener((info, _) => completer.complete(info)),
    );

    ImageInfo imageInfo = await completer.future;
    ByteData? byteData = await imageInfo.image.toByteData(format: ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }
}
