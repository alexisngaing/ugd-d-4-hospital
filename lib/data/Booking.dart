import 'dart:convert';

class Booking {
  int id;
  String nama;
  String deskripsi;
  int umur;
  String picture;

  Booking({
    required this.id,
    required this.nama,
    required this.deskripsi,
    required this.umur,
    required this.picture,
  });

  factory Booking.fromRawJson(String str) => Booking.fromJson(json.decode(str));
  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
      id: json["id"],
      nama: json["nama"],
      deskripsi: json["deskripsi"],
      umur: json["umur"],
      picture: json["picture"]);

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "deskripsi": deskripsi,
        "umur": umur,
        "picture": picture
      };
}
