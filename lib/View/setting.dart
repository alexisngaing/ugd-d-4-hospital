import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ugd_4_hospital/View/profile_kelompok.dart';
import 'package:ugd_4_hospital/View/profile.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  void _navigateToProfile(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Profile(), // Replace with your actual page
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Setting',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('images/profile.png'),
              ),
              title: Text(
                'Zenny Makrya',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  fontSize: 20,
                ),
              ),
            ),
            Divider(height: 50),
            ListTile(
              onTap: () {
                _navigateToProfile(context);
              },
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green.shade300,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Ionicons.person_outline,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              title: Text(
                'Profile',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
              ),
              trailing: Icon(Ionicons.arrow_forward_outline),
            ),
            SizedBox(height: 20),
            ListTile(
              onTap: () {},
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green.shade300,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Ionicons.settings_outline,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              title: Text(
                'General',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
              ),
              trailing: Icon(Ionicons.arrow_forward_outline),
            ),
            SizedBox(height: 20),
            ListTile(
              onTap: () {},
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green.shade300,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Ionicons.shield_outline,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              title: Text(
                'Privacy',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
              ),
              trailing: Icon(Ionicons.arrow_forward_outline),
            ),
            SizedBox(height: 20),
            ListTile(
              onTap: () {},
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green.shade300,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Ionicons.information_circle_outline,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              title: Text(
                'About Us',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
              ),
              trailing: Icon(Ionicons.arrow_forward_outline),
            ),
            SizedBox(height: 20),
            ListTile(
              onTap: () {},
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.red.shade300,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Ionicons.log_out_outline,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              title: Text(
                'Logout',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
              ),
              trailing: Icon(Ionicons.arrow_forward_outline),
            ),
            SizedBox(height: 70),
            ListTile(
              onTap: () {
                _navigateToProfileKelompok(context);
              },
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green.shade300,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Ionicons.person_outline,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              title: Text(
                'Profile Kelompok',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
              ),
              trailing: Icon(Ionicons.arrow_forward_outline),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
