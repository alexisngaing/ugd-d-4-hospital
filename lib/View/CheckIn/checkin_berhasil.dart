import 'package:flutter/material.dart';
import 'package:ugd_4_hospital/View/home.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HalamanBerhasilCheckIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check-In'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.check_circle,
              size: 100.0,
              color: Colors.green,
            ),
            DefaultTextStyle(
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
              child: const Text('Checkin Berhasil!'),
            ),
            ResponsiveSizer(
              builder: (context, sizingInformation, orientation) {
                return SizedBox(height: 20.0);
              },
            ),
            ElevatedButton(
              onPressed: () {
                pushToHome(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              child: const Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}

void pushToHome(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const HomePage()),
  );
}