class Pasien {
  final int? id, umur;

  String? nama, deskripsi, picture;

  Pasien({this.id, this.nama, this.deskripsi, this.umur, this.picture});

  @override
  String toString() {
    return 'Nama {nama: $nama}';
  }
}
