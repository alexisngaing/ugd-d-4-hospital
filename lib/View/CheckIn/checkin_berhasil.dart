import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ugd_4_hospital/View/home.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HalamanBerhasilCheckIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90.w,
              height: 300.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "images/scan-bg.svg",
                    height: 50.h,
                  ),
                  SizedBox(height: 2.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: RichText(
                      text: TextSpan(
                        text: 'Halo! Selamat Datang di Rumah Sakit ini',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        // children: <TextSpan>[
                        //   TextSpan(
                        //     text: ' More text...',
                        //     style: TextStyle(
                        //         fontWeight: FontWeight.bold, fontSize: 18.sp),
                        //   ),
                        // ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  ElevatedButton(
                    onPressed: () {
                      pushToHome(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff15C73C),
                    ),
                    child: const Text('Kembali'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void pushToHome(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const HomePage()),
  );
}
