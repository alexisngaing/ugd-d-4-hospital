import 'package:flutter/material.dart';
import 'package:ugd_4_hospital/component/pasien.dart';

class DetailsScreen extends StatelessWidget {
  final Pasien pasien;

  DetailsScreen({required this.pasien});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pasien'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama: ${pasien.name}'),
            SizedBox(height: 8),
            Text('Usia: ${pasien.age} tahun'),
            SizedBox(height: 8),
            Text('Tinggi Badan: ${pasien.height} cm'),
            SizedBox(height: 8),
            Text('Berat Badan: ${pasien.weight} kg'),
          ],
        ),
      ),
    );
  }
}
