import 'package:flutter/material.dart';

// import 'package:ugd_4_hospital/View/home.dart';
//import 'package:ugd_4_hospital/View/login.dart';
import 'package:ugd_4_hospital/component/splash_screen.dart';
//import 'package:ugd_4_hospital/view/login.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:ugd_4_hospital/View/home.dart';
import 'package:ugd_4_hospital/model/User.dart';

void main() {
  runApp(ProviderScope(child: MainApp()));
}

final userProvider = StateProvider<User>((ref) {
  return User(
    username: "", email: "", password: "", noTelp: "", tanggal: "", image: null,
    // foto: ""
  );
});

class MainApp extends StatelessWidget {
  MainApp({super.key});

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
      return const MaterialApp(
          debugShowCheckedModeBanner: false, home: SplashScreen()
          //LoginPage()
          // //klo mau nyoba aktifin ini
          //HomePage(),
          );
    });
  }
}
