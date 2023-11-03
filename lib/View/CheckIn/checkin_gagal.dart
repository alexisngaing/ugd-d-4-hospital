import 'package:flutter/material.dart';
import 'package:ugd_4_hospital/View/CheckIn/check_in.dart';

class HalamanGagalCheckIn extends StatelessWidget {
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
              Icons.dangerous_rounded,
              size: 100.0,
              color: Colors.green,
            ),
            const Text(
              'Checkin Gagal!',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                pushToCheck(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              child: const Text('CheckIn Kembali'),
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
