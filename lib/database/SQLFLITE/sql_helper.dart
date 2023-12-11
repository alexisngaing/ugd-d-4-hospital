import 'package:sqflite/sqflite.dart' as sql;
import 'package:ugd_4_hospital/model/pasien.dart';

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
  CREATE TABLE pasien(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    nama TEXT,
    deskripsi TEXT,
    umur INTEGER,
    picture TEXT
  )
""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('pasien.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> addPasien(Pasien pasienData) async {
    final db = await SQLHelper.db();
    final data = {
      'nama': pasienData.nama,
      'umur': pasienData.umur,
      'picture': pasienData.picture,
      'deskripsi': pasienData.deskripsi
    };
    return await db.insert('pasien', data);
  }

  static Future<int> editPasien(int id, Pasien pasienData) async {
    final db = await SQLHelper.db();
    final data = {
      'nama': pasienData.nama,
      'umur': pasienData.umur,
      'picture': pasienData.picture,
      'deskripsi': pasienData.deskripsi
    };
    return await db.update('pasien', data, where: "id = $id");
  }

  static Future<int> deletePasien(int id) async {
    final db = await SQLHelper.db();
    return await db.delete('pasien', where: "id = $id");
  }

  static Future<List<Map<String, dynamic>>> getPasien(String search) async {
    final db = await SQLHelper.db();
    return db.query('pasien', where: 'nama LIKE ?', whereArgs: ['%$search%']);
  }

  static Future<Pasien?> getPasienById(int id) async {
    final db = await SQLHelper.db();
    List<Map<String, dynamic>> result =
        await db.query('pasien', where: 'id = $id');
    if (result.isNotEmpty) {
      Pasien pasienData = Pasien(
          id: result.first['id'],
          nama: result.first['nama'],
          umur: result.first['umur'],
          picture: result.first['picture'],
          deskripsi: result.first['deskripsi']);
      return pasienData;
    } else {
      return null;
    }
  }
}
