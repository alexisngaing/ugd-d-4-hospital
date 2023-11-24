import 'package:ugd_4_hospital/data/transaksi.dart';

import 'dart:convert';
import 'package:http/http.dart';

class TransaksiRequest{

  /* Kalo pakai emulator
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api/belanja';
  */

  // Pakai hp
  static final String url = '192.168.210.197'; // sesuaikan ama punya masing2
  static final String endpoint = '/UGD_Hospital_4/public/api/belanja'; // sesuaikan ama punya masing2

  // Ambil data barang
  static Future<List<Transaksi>> fetchAll() async {
    try {
      var response = await get(
          Uri.http(url, endpoint));
      
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];

      return list.map((e) => Transaksi.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Ambil data barang dr API pakai id
  static Future<Transaksi> find(id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return Transaksi.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Create data baru
  static Future<Response> create(Transaksi transaksi) async {
    try {
      var response = await post(Uri.http(url, endpoint),
          headers: {"Content-Type" : "application/json"},
          body: transaksi.toRawJson());
      
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Update data barang
  static Future<Response> update(Transaksi transaksi) async {
    try {
      var response = await put(Uri.http(url, '$endpoint/${transaksi.id}'),
          headers: {"Content-Type" : "application/json"},
          body: transaksi.toRawJson());
      
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Hapus data barang
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