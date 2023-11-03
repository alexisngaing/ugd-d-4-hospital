import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ugd_4_hospital/View/login.dart';
import 'package:ugd_4_hospital/View/profile_kelompok.dart';
import 'package:ugd_4_hospital/View/profile.dart';
import 'package:ugd_4_hospital/View/TextSpeech/textSpeechPage.dart';
import 'package:ugd_4_hospital/View/GeoLocation/geoLocationPage.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  void _navigateToProfile(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Profile(),
      ),
    );
  }

  void _navigateToProfileKelompok(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ProfileKelompok(),
      ),
    );
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  void _navigateToTTS(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const TextToSpeechPage()));
  }

  void _navigateToGeoLocation(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const GeoLocationPage()));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Setting',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            ListTile(
              onTap: () {
                _navigateToProfile(context);
              },
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green.shade300,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Ionicons.person_outline,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              title: const Text(
                'Profile',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
              ),
              trailing: const Icon(Ionicons.arrow_forward_outline),
            ),
            const SizedBox(height: 20),
            ListTile(
              onTap: () {},
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green.shade300,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Ionicons.settings_outline,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              title: const Text(
                'General',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
              ),
              trailing: const Icon(Ionicons.arrow_forward_outline),
            ),
            const SizedBox(height: 20),
            ListTile(
              onTap: () {},
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green.shade300,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Ionicons.shield_outline,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              title: const Text(
                'Privacy',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
              ),
              trailing: const Icon(Ionicons.arrow_forward_outline),
            ),
            const SizedBox(height: 20),
            ListTile(
              onTap: () {
                _navigateToProfileKelompok(context);
              },
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green.shade300,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Ionicons.information_circle_outline,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              title: const Text(
                'About Us',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
              ),
              trailing: const Icon(Ionicons.arrow_forward_outline),
            ),
            const SizedBox(height: 20),
            ListTile(
              onTap: () {
                _navigateToTTS(context);
              },
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green.shade300,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Ionicons.recording_outline,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              title: const Text(
                'Text To Speech',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
              ),
              trailing: const Icon(Ionicons.arrow_forward_outline),
            ),
            const SizedBox(height: 20),
            ListTile(
              onTap: () {
                _navigateToGeoLocation(context);
              },
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green.shade300,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Ionicons.location,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              title: const Text(
                'Get Location',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
              ),
              trailing: const Icon(Ionicons.arrow_forward_outline),
            ),
            const SizedBox(height: 20),
            ListTile(
              onTap: () {
                _navigateToLogin(context);
              },
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.red.shade300,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Ionicons.log_out_outline,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              title: const Text(
                'Logout',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
              ),
              trailing: const Icon(Ionicons.arrow_forward_outline),
            ),
            const SizedBox(height: 160),
          ],
        ),
      ),
    );
  }
}
