import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd_4_hospital/View/Dokter/doctor.dart';
import 'package:ugd_4_hospital/View/home.dart';

class KonsultasiView extends StatefulWidget {
  const KonsultasiView({super.key});

  @override
  State<KonsultasiView> createState() => _KonsultasiViewState();
}

class _KonsultasiViewState extends State<KonsultasiView> {
  List imgs = [
    "doctor1.jpg",
    "doctor2.jpg",
    "doctor3.jpg",
    "doctor4.jpg",
    "doctor5.jpeg",
    "doctor6.jpg",
    "doctor7.jpg",
    "doctor8.jpg",
    "doctor9.jpg",
    "doctor10.jpg",
  ];

  List doctorName = [
    "Dr. Cintya",
    "Dr. Jenny",
    "Dr. Jeon",
    "Dr. Sukma",
    "Dr. Rizky",
    "Dr. Putri",
    "Dr. Ambu",
    "Dr. Jose",
    "Dr. Shaun",
    "Dr. Zee",
  ];

  List doctorRole = [
    "Spesialis Kejiwaan",
    "Dokter Umum",
    "Dokter Gigi",
    "Dokter Umum",
    "Spesialis Kecantikan",
    "Dokter THT",
    "Dokter Umum",
    "Dokter Umum",
    "Dokter Gigi",
    "Psikolog",
  ];

  List experience = [
    "11 Tahun",
    "9 Tahun",
    "10 Tahun",
    "7 Tahun",
    "5 Tahun",
    "8 Tahun",
    "6 Tahun",
    "4 Tahun",
    "3 Tahun",
    "5 Tahun",
  ];

  List stars = [
    "5.0",
    "4.9",
    "4.5",
    "4.7",
    "4.8",
    "4.9",
    "4.6",
    "4.7",
    "4.8",
    "4.9",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Konsultasi Dokter',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xff15C73C),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: GridView.builder(
          padding: const EdgeInsets.all(5),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2.bitLength,
          ),
          itemCount: imgs.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DoctorView(),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage("images/${imgs[index]}"),
                    ),
                    Text(
                      "${doctorName[index]}",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "${doctorRole[index]}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffDDDDDD),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(2),
                                child: Row(
                                  children: [
                                    Icon(
                                      Ionicons.bag,
                                      color: Colors.black,
                                      size: 16.sp,
                                    ),
                                    SizedBox(width: 0.5.w),
                                    Text(
                                      "${experience[index]}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 1.5.w),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffDDDDDD),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(2),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 16.sp,
                                    ),
                                    SizedBox(width: 0.5.w),
                                    Text(
                                      "${stars[index]}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
