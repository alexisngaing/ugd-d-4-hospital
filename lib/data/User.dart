import 'dart:convert';

class User {
  String username;
  String email;
  String password;
  String noTelp;
  String tanggal;
  // String foto;

  User({
    this.username = "",
    this.email = "",
    this.password = "",
    this.noTelp = "",
    this.tanggal = "",
    // this.foto = ""
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));
  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        email: json["email"],
        password: json["password"],
        noTelp: json["noTelp"],
        tanggal: json["tanggal"],
        // foto: json["foto"],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
        "noTelp": noTelp,
        "tanggal": tanggal,
        // "foto": foto,
      };
}
