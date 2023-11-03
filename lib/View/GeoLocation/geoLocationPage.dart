import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ugd_4_hospital/View/setting.dart';
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

  String _currentAddress = "Address";
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
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text("Lokasi Terkini"),
            const SizedBox(height: 6),
            Text(_currentAddress),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                _currentLoc = await _getCurrentLocation();
                await _getAddressLocation();
                print(_currentLoc);
                print(_currentAddress);
              },
              child: const Text('Temukan Lokasi Saya'),
            ),
          ],
        ),
      ),
    );
  }
}
