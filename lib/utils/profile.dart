import 'package:flutter/material.dart';
import 'package:ugd_4_hospital/component/elevatedCard.dart';
import 'package:ugd_4_hospital/component/dataKelompok.dart';
import 'package:ionicons/ionicons.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({super.key, required this.anggota});

  final Kelompok anggota;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 150),
              child: coverImage(),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 150),
              child: profileImage(),
            ),
            Positioned(
              top: 280,
              child: Container(
                child: ElevatedCard(
                  content: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                const CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(255, 219, 233, 255),
                                  child: Icon(
                                    Ionicons.school_outline,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      anggota.universitas,
                                      style: const TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text(
                                      'Universitas',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 137, 137, 137),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 32,
                                ),
                                const CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(255, 219, 233, 255),
                                  child: Icon(
                                    Ionicons.code_outline,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      anggota.programStudi,
                                      style: const TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text(
                                      'Program Studi',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 137, 137, 137),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  width: 8,
                                ),
                                const SizedBox(
                                  width: 32,
                                ),
                                const CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(255, 219, 233, 255),
                                  child: Icon(
                                    Ionicons.ribbon_outline,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${anggota.npm}',
                                      style: const TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text(
                                      'NPM',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 137, 137, 137),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget coverImage() => Container(
      color: Colors.grey,
      child: Container(
        height: 300,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 4, 231, 57),
              Color.fromARGB(255, 23, 245, 141),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ));

  Widget profileImage() => Column(
        children: [
          CircleAvatar(
            backgroundColor: const Color.fromARGB(71, 255, 255, 255),
            radius: 70,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: CircleAvatar(
                backgroundColor: Colors.grey.shade800,
                backgroundImage: AssetImage(anggota.profile),
                radius: double.infinity,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            anggota.nama,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            '${anggota.umur}',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            anggota.email,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          )
        ],
      );
}
