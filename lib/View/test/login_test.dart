import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ugd_4_hospital/View/login.dart';
import 'package:ugd_4_hospital/database/API/UserClient.dart';
import 'package:ugd_4_hospital/main.dart';

void main() {
  testWidgets('Login Success', (WidgetTester tester) async {
    await tester.pumpWidget(const LoginPage());
    await tester.enterText(
        find.byKey(const Key('emailTextField')), 'a@gmail.com');
    await tester.enterText(find.byKey(const Key('passwordTextField')), '12345');
    await tester.tap(find.byKey(const Key('loginButton')));
    await tester.pump();

    expect(find.text('Login Success'), findsOneWidget);
  });

  test('Login Failed', () async {
    final result = await UserClient.login("email@gmail.com", "password");
    expect(result, null);
  });

  testWidgets('widget login success', (WidgetTester tester) async {
    await tester.pumpWidget(LoginPage());
    await tester.enterText(
        find.byKey(const Key('emailTextField')), 'a@gmail.com');
    await tester.enterText(find.byKey(const Key('passwordTextField')), '12345');
    await tester.tap(find.byKey(const Key('loginButton')));
    await tester.pump();

    expect(find.text('Login Success'), findsOneWidget);
  });
}
