import 'dart:convert';
import 'dart:typed_data';

class Transaksi {
  int id;
  String nama;
  String deskripsi;
  String alamat;
  Uint8List? foto;

  Transaksi(
      {required this.id,
      required this.nama,
      required this.deskripsi,
      required this.alamat,
      this.foto});
  
  factory Transaksi.fromRawJson(String str) => Transaksi.fromJson(json.decode(str));
  factory Transaksi.fromJson(Map<String, dynamic> json) => Transaksi(
        id: json["id"],
        nama: json["nama"],
        deskripsi: json["deskripsi"],
        alamat: json["alamat"],
        foto: json["foto"],
  );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "deskripsi": deskripsi,
        "alamat": alamat,
        "foto": foto,
  };
}