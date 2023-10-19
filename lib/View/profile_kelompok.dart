import 'package:flutter/material.dart';
import 'package:ugd_4_hospital/utils/profile.dart';
import 'package:ugd_4_hospital/data/dataKelompok.dart';
import 'package:ionicons/ionicons.dart';

class ProfileKelompok extends StatelessWidget {
  const ProfileKelompok({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: isi.length,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 4, 231, 57),
            bottom: TabBar(
              tabs: isi.map((person) {
                return Tab(
                  icon: Icon(
                    person.gender == 'M'
                        ? Ionicons.man_outline
                        : Ionicons.woman_outline,
                  ),
                );
              }).toList(),
            ),
            title: const Text('Profile Kelompok'),
          ),
          body: TabBarView(
            children: isi.map((person) {
              return ProfileItem(anggota: person);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
