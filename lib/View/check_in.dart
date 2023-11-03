import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:ugd_4_hospital/View/checkin_berhasil.dart';

class CheckInPage extends StatefulWidget {
  const CheckInPage({Key? key}) : super(key: key);

  @override
  State<CheckInPage> createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController _qrController;

  @override
  void dispose() {
    _qrController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check-In'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: ElevatedButton(
                onPressed: () async {
                  _qrController.toggleFlash();
                },
                child: const Text('Toggle Flash'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // Atur warna tombol menjadi hijau
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    _qrController = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code != null && scanData.code!.isNotEmpty) {
        // Lakukan peralihan ke halaman berhasil check-in
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HalamanBerhasilCheckIn(),
          ),
        );
      }
    });
  }
}