import 'package:ugd_4_hospital/model/Booking.dart';

import 'dart:convert';
import 'package:http/http.dart';

class BookingClient {
  static final String url = '20.40.99.235:8000';
  static final String endpoint = 'api/book';

  // For Linux
  // static final String url = '127.0.0.1:8000';
  // static final String endpoint = 'api/user';

  static final String end = 'api/search/{nama}';

  static Future<List<Booking>> fetchAll() async {
    try {
      var response = await get(Uri.http(url, endpoint));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];

      return list.map((e) => Booking.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<List<Booking>> search(String nama) async {
    try {
      var response = await get(Uri.http(url, '/api/search/$nama'));
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      Iterable list = json.decode(response.body)['data'];
      return list.map((e) => Booking.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Booking> find(id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$id'));
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return Booking.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> create(Booking book) async {
    try {
      var response = await post(Uri.http(url, endpoint),
          headers: {"Content-Type": "application/json"},
          body: book.toRawJson());

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> update(Booking book) async {
    try {
      var response = await put(Uri.http(url, '$endpoint/${book.id}'),
          headers: {"Content-Type": "application/json"},
          body: book.toRawJson());

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> destroy(id) async {
    try {
      var response = await delete(Uri.http(url, '$endpoint/$id'));
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
