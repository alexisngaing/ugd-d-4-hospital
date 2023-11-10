import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:ugd_4_hospital/View/CheckIn/checkin_berhasil.dart';
import 'package:ugd_4_hospital/View/CheckIn/checkin_gagal.dart';
import 'package:ugd_4_hospital/View/home.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
        title: ResponsiveSizer(
          builder: (context, sizingInformation, orientation) {
            return Text(
              'Check-In',
              style: TextStyle(
                fontSize: 16.sp,
              ),
            );
          },
        ),
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: ResponsiveSizer(builder: (context, orientation, deviceType) {
              return QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              );
            }),
          ),
          Expanded(
            flex: 1,
            child: ResponsiveSizer(builder: (context, orientation, deviceType) {
              return Center(
                child: ElevatedButton(
                  onPressed: () async {
                    _qrController.toggleFlash();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  child: const Text('Toggle Flash'),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    _qrController = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code != null && scanData.code!.isNotEmpty) {
        if (isQRCodeValid(scanData.code)) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HalamanBerhasilCheckIn(),
            ),
          );
        } else {
          // QR code tidak sesuai, tampilkan pesan kesalahan
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HalamanGagalCheckIn(),
            ),
          );
        }
      }
    });
  }

  bool isQRCodeValid(String? qrCodeData) {
    String expectedURL =
        'https://www.qrcode-monkey.com'; // Sesuaikan dengan URL yang diharapkan
    return qrCodeData == expectedURL;
  }
}