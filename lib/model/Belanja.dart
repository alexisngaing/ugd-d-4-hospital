import 'dart:convert';

class Belanja {
  int id;
  String nama;
  String deskripsi;
  String alamat;
  String foto;

  Belanja(
      {required this.id,
      required this.nama,
      required this.deskripsi,
      required this.alamat,
      required this.foto});

  factory Belanja.fromRawJson(String str) => Belanja.fromJson(json.decode(str));
  factory Belanja.fromJson(Map<String, dynamic> json) => Belanja(
        id: json["id"],
        nama: json["nama"],
        deskripsi: json["deskripsi"],
        alamat: json["alamat"],
        foto: json['foto'],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "deskripsi": deskripsi,
        "alamat": alamat,
        "foto": foto
      };
}
