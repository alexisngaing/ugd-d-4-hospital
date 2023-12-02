import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:ugd_4_hospital/page/booking_input_page.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  testWidgets('Test adding Pasien', (WidgetTester tester) async {
    MockClient((request) async {
      if (request.url.path == '/api/user') {
        return Response('{"data": {"create": "User"}}', 200);
      }
      return Response('Not Found', 404);
    });
    await tester.pumpWidget(const MaterialApp(
      home: PasienInputPage(),
    ));

    await tester.enterText(find.byKey(const ValueKey('nama')), 'Test Pasien');
    await tester.enterText(
        find.byKey(const ValueKey('deskripsi')), 'Deskripsi Pasien');
    await tester.enterText(find.byKey(const ValueKey('umur')), '25');
    await tester.enterText(find.byKey(const ValueKey('dokter')), 'Dokter ABC');

    await tester.tap(find.text('Tambah'));
    await tester.pumpAndSettle();

    expect(find.byType(ScaffoldMessenger), findsOneWidget);
  });
}
