import 'package:flutter/material.dart';
import 'package:ugd_4_hospital/View/home.dart';

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
            const Text(
              'Checkin Berhasil!',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
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
