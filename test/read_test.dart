import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ugd_4_hospital/View/Pasien/pasienView.dart';
import 'package:ugd_4_hospital/data/Booking.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  testWidgets('Test PasienView Widget', (WidgetTester tester) async {
    final MockNavigatorObserver mockObserver = MockNavigatorObserver();
    final bookingTestData = Booking(
      id: 1,
      nama: 'John Doe',
      deskripsi: 'Some description',
      umur: 25,
      picture: 'profile_picture',
    );
    final listPasien = Provider<List<Booking>>((ref) => [bookingTestData]);

    await tester.pumpWidget(
      MaterialApp(
        home: ProviderScope(
          overrides: [
            listPasien.overrideWithValue([bookingTestData]),
          ],
          child: PasienView(),
        ),
        navigatorObservers: [mockObserver],
      ),
    );
    expect(find.text('Data Booking'), findsOneWidget);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsNothing);

    print(find.byType(FloatingActionButton).evaluate().length);
    print(find.byType(SingleChildScrollView).evaluate().length);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
  });

  // testWidgets('Test PasienView Widget', (WidgetTester tester) async {
  //   final MockNavigatorObserver mockObserver = MockNavigatorObserver();

  //   await tester.pumpWidget(
  //     MaterialApp(
  //       home: ProviderScope(
  //         child: PasienView(),
  //       ),
  //       navigatorObservers: [mockObserver],
  //     ),
  //   );
  //   Booking input = Booking(
  //     id: 1,
  //     nama: 'John Doe',
  //     deskripsi: 'Some description',
  //     umur: 25,
  //     picture: 'profile_picture',
  //   );
  //   final myProvider = Provider<Booking>((ref) => input);
  //   final listPasienProvider = ProviderContainer().read<dynamic>(myProvider);

  //   final container = ProviderContainer();

  //   await tester.pumpAndSettle();

  //   // Assert that the view is updated
  //   expect(find.text('John Doe'), findsOneWidget);

  //   // Add another booking
  //   container.read(listPasienProvider).add(
  //         Booking(
  //           id: 2,
  //           nama: 'Jane Doe',
  //           deskripsi: 'Some other description',
  //           umur: 26,
  //           picture: 'profile_picture2',
  //         ),
  //       );

  //   await tester.pumpAndSettle();

  //   // Assert that the view is updated with the second booking
  //   expect(find.text('Jane Doe'), findsOneWidget);
  // });
}
