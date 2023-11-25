import 'package:flutter/material.dart';
import 'package:ugd_4_hospital/View/home.dart';
import 'package:ugd_4_hospital/View/login.dart';
// import 'package:ugd_4_hospital/view/login.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, deviceType) {
      Device.orientation == Orientation.portrait
          ? Container(
              width: 100.w,
              height: 20.5.h,
            )
          : Container(
              width: 100.w,
              height: 12.5.h,
            );
      Device.screenType == ScreenType.tablet
          ? Container(
              width: 100.w,
              height: 20.5.h,
            )
          : Container(
              width: 100.w,
              height: 12.5.h,
            );
      return const MaterialApp(home: LoginPage()
          //klo mau nyoba aktifin ini
          // HomePage(),
          );
    });
  }
}
