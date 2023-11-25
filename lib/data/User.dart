import 'dart:convert';

class User {
  String username;
  String email;
  String password;
  String noTelp;
  String? tanggal;

  User(
      {required this.username,
      required this.email,
      required this.password,
      required this.noTelp,
      this.tanggal});

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));
  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        email: json["email"],
        password: json["password"],
        noTelp: json["noTelp"],
        tanggal: json["tanggal"],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
        "noTelp": noTelp,
        "tanggal": tanggal,
      };
}
