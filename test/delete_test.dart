import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ugd_4_hospital/View/Pasien/pasienView.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  setUpAll(() => HttpOverrides.global = null);

  testWidgets('Show Data Booking Widget - Show Data Booking',
      (WidgetTester tester) async {
    final screenSize = tester.binding.window.physicalSize /
        tester.binding.window.devicePixelRatio;

    await tester.binding.setSurfaceSize(screenSize);

    await tester.runAsync(() async {
      await tester.pumpWidget(
        ResponsiveSizer(
          builder: (context, orientation, deviceType) {
            return MaterialApp(
              home: Container(
                width: 500.0,
                height: 1000.0,
                child: ProviderScope(child: PasienView()),
              ),
            );
          },
        ),
      );
      await tester.pumpAndSettle(Duration(seconds: 5));
      await tester.pump(Duration(seconds: 3));
      await tester.tapAt(Offset(358.5, 203.0));
      await tester.pumpAndSettle();
    });
  });
}
