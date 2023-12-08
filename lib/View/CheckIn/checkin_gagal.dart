import 'package:flutter/material.dart';
import 'package:ugd_4_hospital/View/CheckIn/check_in.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HalamanGagalCheckIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check-In'),
        backgroundColor: const Color(0xff15C73C),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.dangerous_rounded,
              size: 150.0,
              color: Colors.red,
            ),
            DefaultTextStyle(
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
              child: const Text('Checkin Gagall!'),
            ),
            ResponsiveSizer(
              builder: (context, sizingInformation, orientation) {
                return SizedBox(height: 20.0);
              },
            ),
            ElevatedButton(
              onPressed: () {
                pushToCheck(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff15C73C),
              ),
              child: const Text('Check-in Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}

void pushToCheck(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const CheckInPage()),
  );
}
