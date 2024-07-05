import 'package:firebase/utility/customPackage/custom_class.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class AddressFromMap extends StatefulWidget {
  const AddressFromMap({super.key});

  @override
  State<AddressFromMap> createState() => _AddressFromMapState();
}

class _AddressFromMapState extends State<AddressFromMap> {
  String dataOfText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Address Theme"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(dataOfText),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customMaterialButtonWidget2(
                  width: 120,
                  content: Text(
                    "Convert",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () async {
                    try {
                      final double latitude = 22.307564;
                      final double longitude = 70.324579;
                      List<Placemark> placemarks =await placemarkFromCoordinates(latitude, longitude);
                      Placemark place = placemarks.first;
                      print("Feature Name: ${place.name}");
                      print("Address Line: ${place.street}, ${place.locality}, ${place.country}");
                      setState(() {
                        dataOfText ="${place.name}:${place.country}\n${place.locality}:${place.postalCode}:${place.isoCountryCode}\n${place.administrativeArea}";
                      });
                      String address ="Jamnagar india Gujarat   361113";
                      List<Location> _location =
                          await locationFromAddress(address);
                      Location locationcor = _location.first;
                      print(locationcor.latitude);
                      print(locationcor.longitude);
                    } catch (e) {
                      print("noo");
                      print(e);
                    }
                  }),
            ],
          )
        ],
      ),
    );
  }
}
