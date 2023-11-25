import 'dart:convert';

class User {
  int id;
  String username;
  String email;
  String password;
  String noTelp;
  DateTime tanggal;
  String foto;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.noTelp,
    required this.tanggal,
    required this.foto,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));
  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        noTelp: json["no_telp"],
        tanggal: DateTime.parse(json["tanggal"]),
        foto: json["foto"],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "password": password,
        "no_telp": noTelp,
        "tanggal": tanggal.toIso8601String(),
        "foto": foto,
      };
}
