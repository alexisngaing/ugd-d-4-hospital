import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ugd_4_hospital/View/Pasien/pasienView.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  setUpAll(() => HttpOverrides.global = null);

  testWidgets('Edit Data Booking Widget - Edit Data Booking',
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
                width: 500.0, // Adjust the width as needed
                height: 1000.0,
                child: ProviderScope(child: PasienView()),
              ),
            );
          },
        ),
      );
      await tester.pumpAndSettle(Duration(seconds: 5));
      await tester.pumpAndSettle();
      await tester.tapAt(Offset(181.7, 207.2));
      await tester.pumpAndSettle();

      expect(find.byKey(const ValueKey('nama')), findsOneWidget);
      expect(find.byKey(const ValueKey('deskripsi')), findsOneWidget);
      expect(find.byKey(const ValueKey('umur')), findsOneWidget);
      expect(find.byKey(const ValueKey('dokter')), findsOneWidget);

      await tester.enterText(find.byKey(const ValueKey('nama')), 'Test Pasien');
      await tester.enterText(
          find.byKey(const ValueKey('deskripsi')), 'Deskripsi Pasien');
      await tester.enterText(find.byKey(const ValueKey('umur')), '25');
      await tester.enterText(find.byKey(const ValueKey('dokter')), 'gambar');

      await tester.pumpAndSettle();
      await tester.pump(Duration(seconds: 5));

      final editButton = find.widgetWithText(ElevatedButton, 'Edit');
      expect(editButton, findsOneWidget);
      await tester.tap(editButton);
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();
    });
  });
}
