import 'package:flutter/material.dart';
import 'package:ugd_4_hospital/component/pasien.dart';
import 'package:ugd_4_hospital/pasien_hospital/detailPasien.dart';
import 'package:ugd_4_hospital/pasien_hospital/pasienScreen.dart';

class PasienList extends StatelessWidget {
  final List<Pasien> listPasien;

  PasienList({required this.listPasien});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Pasien'),
      ),
      body: ListView.builder(
        itemCount: listPasien.length,
        itemBuilder: (context, index) {
          final currentPasien = listPasien[index];
          return Card(
            child: ListTile(
              title: Text(currentPasien.name),
              subtitle: Text('Usia: ${currentPasien.age} tahun'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(pasien: currentPasien),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InputPasien(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
