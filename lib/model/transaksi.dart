import 'dart:typed_data';

class Transaksi {
  final int? id;
  String? nama, deskripsi, alamat;
  Uint8List? foto;
  Transaksi({this.id, this.nama, this.deskripsi, this.alamat, this.foto});

  @override
  String toString() {
    return 'Nama {nama: $nama}';
  }
}
