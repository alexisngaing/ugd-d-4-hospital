import 'package:ugd_4_hospital/model/User.dart';
import 'dart:convert';
// import 'package:ugd_4_hospital/database/API/api_Client.dart';
import 'package:http/http.dart' as http;

class UserClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = 'api/user';
  static http.Client? _httpClient;

  // static final String url = '172.16.98.59';
  // static final String endpoint = 'api/user';
  // static final String url = '192.168.18.13';
  // static final String endpoint = '/ugd-d-4-hospital/public/api/user';

  // For Linux
  // static final String url = '127.0.0.1:8000';
  // static final String endpoint = 'api/user';

  static http.Client get httpClient {
    if (_httpClient == null) {
      _httpClient = http.Client();
    }
    return _httpClient!;
  }

  static set httpClient(http.Client client) {
    _httpClient = client;
  }

  static Future<List<User>> fetchAll() async {
    try {
      var response = await http.get(Uri.http(url, endpoint));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];

      return list.map((e) => User.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<User> find(email) async {
    try {
      var response = await http.get(Uri.http(url, '$endpoint/$email'));
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return User.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<http.Response> create(User user) async {
    try {
      print(user.toRawJson());
      var response = await http.post(Uri.http(url, endpoint),
          headers: {"Content-Type": "application/json"},
          body: user.toRawJson());
      print(response.body);
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      print("Register success!!");
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    try {
      var response = await http.post(
        Uri.http(url, '/api/login/$email/$password'),
        headers: {"Content-type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      if (response.statusCode == 200) {
        return {
          "status": true,
          "message": "Login Berhasil",
          "data": jsonDecode(response.body)['data'],
        };
      } else {
        return {
          "status": false,
          "message": "Login Gagal",
          "data": null,
        };
      }
    } catch (e) {
      return {
        "status": false,
        "message": e.toString(),
        "data": null,
      };
    }
  }

  static Future<User?> logintesting({
    required String email,
    required String password,
  }) async {
    String apiURL = 'http://127.0.0.1:8000/api/login';
    try {
      var apiResult = await http.post(
        Uri.parse(apiURL),
        body: {'email': email, 'password': password},
      );
      if (apiResult.statusCode == 200) {
        final result = User.fromRawJson(apiResult.body);
        return result;
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      return null;
    }
  }

  static Future<http.Response> update(User user) async {
    try {
      var response = await http.put(
        Uri.http(url, 'api/update/${user.email}'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": user.username,
          "email": user.email,
          "password": user.password,
          "noTelp": user.noTelp,
          "tanggal": user.tanggal,
          "image": user.image,
        }),
      );
      print(response.body);
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Future<User> update(User user) async {
  //   try {
  //     var response = await http.post(
  //       Uri.http(url, 'api/update/${user.email}'),
  //       headers: {
  //         "Content-Type": "application/json",
  //       },
  //       body: jsonEncode({
  //         "username": user.username,
  //         "email": user.email,
  //         "password": user.password,
  //         "noTelp": user.noTelp,
  //         "tanggal": user.tanggal,
  //         "image": user.image,
  //       }),
  //     );
  //     print(response.body);
  //     if (response.statusCode == 200) {
  //       var json = response.body;
  //       var jsonData = jsonDecode(json);
  //       var userJson = jsonData['data'];
  //       return User.fromJson(userJson);
  //     } else {
  //       var json = response.body;
  //       var jsonData = jsonDecode(json);
  //       throw (jsonData['message'] ?? 'Update Failed');
  //     }
  //   } finally {
  //     //client.close();
  //   }
  // }
}
