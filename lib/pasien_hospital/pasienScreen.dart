import 'package:flutter/material.dart';
import 'package:ugd_4_hospital/component/pasien.dart';

class InputPasien extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  List<Pasien> pasien = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Data Pasien Baru'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: ageController,
              decoration: InputDecoration(labelText: 'Usia'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextField(
              controller: heightController,
              decoration: InputDecoration(labelText: 'Tinggi Badan (cm)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextField(
              controller: weightController,
              decoration: InputDecoration(labelText: 'Berat Badan (kg)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final name = nameController.text;
                final age = int.parse(ageController.text);
                final height = double.parse(heightController.text);
                final weight = double.parse(weightController.text);
                final newPasien= Pasien(
                  id: pasien.length + 1,
                  name: name,
                  age: age,
                  height: height,
                  weight: weight,
                );
                pasien.add(newPasien);
                Navigator.pop(context);
              },
              child: Text('Add Patient'),
            ),
          ],
        ),
      ),
    );
  }
}
