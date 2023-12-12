import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ugd_4_hospital/View/register.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  testWidgets('RegisterView Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      ResponsiveSizer(
        builder: (context, orientation, deviceType) {
          final double containerHeight =
              Device.orientation == Orientation.portrait ? 1000.h : 1000.h;

          return MaterialApp(
            home: SizedBox(
              width: 500.w,
              height: containerHeight,
              child: const RegisterView(),
            ),
          );
        },
      ),
    );

    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('No Telp'), findsOneWidget);
    expect(find.text('Tanggal'), findsOneWidget);
    expect(find.text('Verifikasi No Telp (3 digit terakhir)'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);

    await tester.enterText(
        find.byKey(const ValueKey('username')), 'test_username');
    await tester.enterText(
        find.byKey(const ValueKey('email')), 'test@example.com');
    await tester.enterText(
        find.byKey(const ValueKey('password')), 'test_password');
    await tester.enterText(find.byKey(const ValueKey('noTelp')), '123456789');
    await tester.enterText(
        find.byKey(const ValueKey('noTelpVerification')), '789');

    await tester.tap(find.byKey(const ValueKey('tanggal')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();
    expect(find.byType(ScaffoldMessenger), findsOneWidget);
  });
}
