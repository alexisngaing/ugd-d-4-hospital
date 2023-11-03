import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class GeoLocationPage extends StatefulWidget {
  const GeoLocationPage({super.key});

  @override
  State<GeoLocationPage> createState() => _GeoLocationState();
}

class _GeoLocationState extends State<GeoLocationPage> {
  Position? _currentLoc;
  late bool servicePermission = false;
  late LocationPermission permission;

  String _currentAddress = "";
  Future<Position> _getCurrentLocation() async {
    servicePermission = await Geolocator.isLocationServiceEnabled();
    if (!servicePermission) {
      print("Service Disabled");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<void> _getAddressLocation() async {
    await placemarkFromCoordinates(
            _currentLoc!.latitude, _currentLoc!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      print("Error : $e");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get Location'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Lokasi Anda",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(_currentAddress),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                _currentLoc = await _getCurrentLocation();
                await _getAddressLocation();
                print(_currentLoc);
                print(_currentAddress);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.location_pin),
                  SizedBox(width: 8), // Spasi antara ikon dan teks
                  Text('Temukan Lokasi Saya'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
