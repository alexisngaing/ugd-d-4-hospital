import 'package:sqflite/sqflite.dart' as sql;
import 'package:ugd_4_hospital/model/transaksi.dart';

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
  CREATE TABLE transaksi(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    nama TEXT,
    deskripsi TEXT,
    alamat TEXT,
    foto TEXT
  )
""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('transaksi.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> addTransaksi(Transaksi transaksiData) async {
    final db = await SQLHelper.db();
    final data = {
      'nama': transaksiData.nama,
      'deskripsi': transaksiData.deskripsi,
      'alamat': transaksiData.alamat,
      'foto': transaksiData.foto
    };
    return await db.insert('transaksi', data);
  }

  static Future<int> editTransaksi(int id, Transaksi transaksiData) async {
    final db = await SQLHelper.db();
    final data = {
      'nama': transaksiData.nama,
      'deskripsi': transaksiData.deskripsi,
      'alamat': transaksiData.alamat,
      'foto': transaksiData.foto
    };
    return await db.update('transaksi', data, where: "id = $id");
  }

  static Future<int> deleteTransaksi(int id) async {
    final db = await SQLHelper.db();
    return await db.delete('transaksi', where: "id = $id");
  }

  static Future<List<Map<String, dynamic>>> getTransaksi(String search) async {
    final db = await SQLHelper.db();
    return db
        .query('transaksi', where: 'nama LIKE ?', whereArgs: ['%$search%']);
  }

  static Future<Transaksi?> getTransaksiById(int id) async {
    final db = await SQLHelper.db();
    List<Map<String, dynamic>> result =
        await db.query('transaksi', where: 'id = $id');
    if (result.isNotEmpty) {
      Transaksi transaksiData = Transaksi(
          id: result.first['id'],
          nama: result.first['nama'],
          deskripsi: result.first['deskripsi'],
          alamat: result.first['alamat'],
          foto: result.first['foto']);
      return transaksiData;
    } else {
      return null;
    }
  }
}
