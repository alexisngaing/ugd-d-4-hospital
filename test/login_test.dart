import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

import 'package:ugd_4_hospital/View/login.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
//import 'package:ugd_4_hospital/database/API/UserClient.dart';

void main() {
  setUpAll(() => HttpOverrides.global = null);
  testWidgets('LoginPage widget test', (WidgetTester tester) async {
    MockClient((request) async {
      if (request.url.path == '/api/login') {
        return Response('{"data": {"email": "User"}}', 200);
      }
      return Response('Not Found', 404);
    });

    await tester.pumpWidget(
      ResponsiveSizer(
        builder: (context, orientation, deviceType) {
          final double containerHeight =
              Device.orientation == Orientation.portrait ? 20.5.h : 12.5.h;

          return MaterialApp(
            home: SizedBox(
              width: 100.w,
              height: containerHeight,
              child: const ProviderScope(child: LoginPage()),
            ),
          );
        },
      ),
    );

    await tester.enterText(find.byKey(const Key('email')), 'testLogin');
    await tester.enterText(
        find.byKey(const Key('password')), 'testLoginPassword');

    await tester.tap(find.byType(ElevatedButton));

    await tester.pumpAndSettle();

    expect(find.text('Login Sukses'), findsOneWidget);
  });
}
