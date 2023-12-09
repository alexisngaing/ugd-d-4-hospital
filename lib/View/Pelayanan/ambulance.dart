import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AmbulanceView extends StatefulWidget {
  const AmbulanceView({super.key});

  @override
  State<AmbulanceView> createState() => _AmbulanceViewState();
}

class _AmbulanceViewState extends State<AmbulanceView> {
  List location = [
    "RS Panti Rapih",
    "Siloam Hospital",
    "RSUP Dr. Sardjito",
  ];

  List status = [
    "Tersedia",
    "Tersedia",
    "Tersedia",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ambulance',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xff15C73C),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 1.h),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 8.0, horizontal: 16.0), // Adjust padding as needed
              child: Text(
                'Ambulance terdekat dari lokasi Anda',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ListView.builder(
              padding: const EdgeInsets.all(15),
              // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //   crossAxisCount: 2.bitLength,
              // ),
              itemCount: location.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const DoctorView(),
                        //   ),
                        // );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.center,
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
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    location[index],
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    status[index],
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: const Color(0xff15C73C),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 4,
                                                spreadRadius: 2,
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              FaIcon(
                                                Ionicons
                                                    .chatbubble_ellipses_outline,
                                                size: 22.sp,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 2.w),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: const Color(0xff15C73C),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 4,
                                                spreadRadius: 2,
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              FaIcon(
                                                Ionicons.call_outline,
                                                size: 22.sp,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ]),
                      ),
                    ),
                    SizedBox(height: 1.2.h),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
