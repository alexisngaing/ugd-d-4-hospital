import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ugd_4_hospital/database/API/BookingClient.dart';
import 'package:ugd_4_hospital/data/Booking.dart';
import 'package:ugd_4_hospital/View/Pasien/pasienView.dart';
import 'package:http/http.dart';

// class MockBookingClient extends Mock implements BookingClient{}

class MockBookingClient extends Mock implements BookingClient {
  @override
  Future<List<Booking>> fetchAll() async {
    return Future.value([
      Booking(
        id: 1,
        nama: 'John Doe',
        deskripsi: 'Test Deskripsi',
        umur: 30,
        picture: 'https://example.com/picture.jpg',
      ),
    ]);
  }

  @override
  Future<Response> create(Booking book) async {
    return Future.value(Response('Success', 200));
  }

  @override
  Future<Response> update(Booking book) async {
    return Future.value(Response('Success', 200));
  }

  @override
  Future<Response> destroy(dynamic id) async {
    return Future.value(Response('Success', 200));
  }
}

void main() {
  testWidgets('Widget Test for API Data Fetching and CRUD Operations', (WidgetTester tester) async {
    final MockBookingClient mockBookingClient = MockBookingClient();

    final List<Booking> fakeData = [
      Booking(
        id: 1,
        nama: 'John Doe',
        deskripsi: 'Test Deskripsi',
        umur: 30,
        picture: 'https://example.com/picture.jpg',
      ),
    ];

    when(mockBookingClient.fetchAll())
        .thenAnswer((_) async => Future.value(fakeData));

    when(mockBookingClient.create(any))
        .thenAnswer((_) async => Future.value(Response('Success', 200)));

    when(mockBookingClient.update(any))
        .thenAnswer((_) async => Future.value(Response('Success', 200)));

    when(mockBookingClient.destroy(any))
        .thenAnswer((_) async => Future.value(Response('Success', 200)));

    await tester.pumpWidget(MaterialApp(
      home: PasienView(),
    ));

    await tester.pump();

    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('Test Deskripsi'), findsOneWidget);
    expect(find.text('30'), findsOneWidget);
    expect(find.text('https://example.com/picture.jpg'), findsOneWidget);

    expect(find.text('Tambah'), findsOneWidget);
    expect(find.text('Edit'), findsOneWidget);

    await tester.tap(find.text('Tambah'));
    await tester.pump();

    expect(find.text('Masukkan Nama'), findsOneWidget);
    expect(find.text('Masukkan Deskripsi'), findsOneWidget);
    expect(find.text('Masukkan Umur'), findsOneWidget);
    expect(find.text('Masukkan Nama Dokter'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), 'Jane Doe');
    await tester.enterText(find.byType(TextFormField).at(1), 'Another description');
    await tester.enterText(find.byType(TextFormField).at(2), '25');
    await tester.enterText(find.byType(TextFormField).at(3), 'https://example.com/another.jpg');

    await tester.tap(find.text('Tambah'));
    await tester.pump();

    expect(find.text('Jane Doe'), findsOneWidget);
    expect(find.text('Another description'), findsOneWidget);
    expect(find.text('25'), findsOneWidget);
    expect(find.text('https://example.com/another.jpg'), findsOneWidget);

    await tester.tap(find.text('Edit'));
    await tester.pump();

    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('Test Deskripsi'), findsOneWidget);
    expect(find.text('30'), findsOneWidget);
    expect(find.text('https://example.com/picture.jpg'), findsOneWidget);

    await tester.tap(find.text('Edit'));
    await tester.pump();

    expect(find.text('Success'), findsWidgets);
    
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pump();

    
    expect(find.text('Success'), findsWidgets);
  });
}
