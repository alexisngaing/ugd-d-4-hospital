import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ugd_4_hospital/View/Pasien/pasienView.dart';
import 'package:ugd_4_hospital/page/booking_input_page.dart';
// import 'package:ugd_4_hospital/database/API/BookingClient.dart';
// import 'package:intl/intl.dart';
// import 'package:guidedlayout2_1352/data/obatProduk.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:guidedlayout2_1352/client/obatClient.dart';

void main() {
  setUpAll(() => HttpOverrides.global = null);

  // testWidgets('MenuHome Widget - Create Data Obat', (WidgetTester tester) async {
  //   final screenSize = tester.binding.window.physicalSize / tester.binding.window.devicePixelRatio;

  //   await tester.binding.setSurfaceSize(screenSize);

  //   await tester.runAsync(() async {
  //     await tester.pumpWidget(
  //       ResponsiveSizer(
  //         builder: (context, orientation, deviceType) {
  //           return MaterialApp(
  //             home: Container(
  //               width: 500.0, // Adjust the width as needed
  //               height: 1000.0, // Adjust the height as needed
  //               child: const MenuHome(),
  //             ),
  //           );
  //         },
  //       ),
  //     );
  //     await tester.pumpAndSettle();
  //     // await tester.pump(Duration(seconds: 0));

  //     await tester.tapAt(Offset(368.0, 50.5));
  //     await tester.pumpAndSettle();

  //     expect(find.byKey(ValueKey('namaObat')), findsOneWidget);
  //     expect(find.byKey(ValueKey('description')), findsOneWidget);
  //     expect(find.byKey(ValueKey('hargaObat')), findsOneWidget);
  //     expect(find.byKey(ValueKey('kategori')), findsOneWidget);
  //     expect(find.byType(ElevatedButton), findsNWidgets(2));
  //     await tester.pumpAndSettle();

  //     await tester.tap(find.widgetWithText(ElevatedButton, 'Ambil Foto Obat'));
  //     await tester.pumpAndSettle();

  //     await tester.tap(find.widgetWithIcon(GestureDetector, Icons.camera_alt));
  //     await tester.pumpAndSettle();

  //     await tester.pump(Duration(seconds: 30));
  //     await tester.enterText(find.byKey(ValueKey('namaObat')), 'Vitamin A');
  //     await tester.enterText(find.byKey(ValueKey('description')), '1');
  //     await tester.enterText(find.byKey(ValueKey('hargaObat')), '99999');
  //     await tester.enterText(find.byKey(ValueKey('kategori')), '1');
  //     await tester.pumpAndSettle();
  //     await tester.pump(Duration(seconds: 5));

  //     await tester.tapAt(Offset(198.5, 773.4));
  //   });
  // });

//DELETE DATA OBAT
  testWidgets('MenuHome Widget - Delete Data Obat',
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
                  height: 1000.0, // Adjust the height as needed
                  child: ProviderScope(child: PasienView())),
            );
          },
        ),
      );
      await tester.pump(Duration(seconds: 5));

      await tester.pumpAndSettle();

      await tester.tapAt(Offset(151.6, 392.0));
      await tester.pumpAndSettle();
    });
  });

//EDIT DATA OBAT
// testWidgets('MenuHome Widget - Edit Data Obat', (WidgetTester tester) async {
//   final screenSize = tester.binding.window.physicalSize / tester.binding.window.devicePixelRatio;

//   await tester.binding.setSurfaceSize(screenSize);

//   await tester.runAsync(() async {
//     await tester.pumpWidget(
//       ResponsiveSizer(
//         builder: (context, orientation, deviceType) {
//           return MaterialApp(
//             home: Container(
//               width: 500.0, // Adjust the width as needed
//               height: 1000.0, // Adjust the height as needed
//               child: const MenuHome(),
//             ),
//           );
//         },
//       ),
//     );
//     await tester.pump(Duration(seconds: 5));

//     await tester.pumpAndSettle();

//     await tester.tapAt(Offset(38.5, 388.7));
//     await tester.pumpAndSettle();

//     // await tester.tap(find.widgetWithText(ElevatedButton, 'Ambil Foto Obat'));
//     // await tester.pumpAndSettle();
//     // await tester.pump();

//     // await tester.tap(find.widgetWithIcon(GestureDetector, Icons.camera_alt));
//     // await tester.pumpAndSettle();
//     // await tester.pump(Duration(seconds: 30));

//     expect(find.byKey(ValueKey('namaObat')), findsOneWidget);
//     expect(find.byKey(ValueKey('description')), findsOneWidget);
//     expect(find.byKey(ValueKey('hargaObat')), findsOneWidget);
//     expect(find.byKey(ValueKey('kategori')), findsOneWidget);
//     expect(find.byType(ElevatedButton), findsNWidgets(2));
//     await tester.pumpAndSettle();

//     await tester.enterText(find.byKey(ValueKey('namaObat')), 'Vitamin D');
//     await tester.enterText(find.byKey(ValueKey('description')), 'Ternyata cuma kurang');
//     await tester.enterText(find.byKey(ValueKey('hargaObat')), '99999');
//     await tester.enterText(find.byKey(ValueKey('kategori')), 'Penambah Daya Tahan Tubuh');
  // await tester.pumpAndSettle();
  // await tester.pump(Duration(seconds: 5));

  // await tester.tapAt(Offset(166.2, 775.6));

  // final saveButton = find.widgetWithText(ElevatedButton, 'Save');
  // expect(saveButton, findsOneWidget);
  // await tester.tap(saveButton);
  // await tester.pumpAndSettle();
//   });
// });

  testWidgets('MenuHome Widget - Show Data Obat', (WidgetTester tester) async {
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
                height: 1000.0, // Adjust the height as needed
                child: ProviderScope(child: PasienView()),
              ),
            );
          },
        ),
      );
      await tester.pumpAndSettle(Duration(seconds: 5));
      await tester.pump(Duration(seconds: 5));
      await tester.pumpAndSettle();

      await tester.tapAt(Offset(118.2, 242.2));
      await tester.pumpAndSettle();

      await tester.drag(
          find.byKey(const Key('scroll')), const Offset(0.0, -300.0));
      await tester.pumpAndSettle();

      await tester.tapAt(Offset(123.6, 738.9));
      await tester.pumpAndSettle();
    });
  });
}
