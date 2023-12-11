import 'package:sqflite/sqflite.dart' as sql;
import 'dart:typed_data';

class SQLHelperProfile {
  static Future<void> createTables(sql.Database database) async {
    await database.execute('''
      CREATE TABLE daftar(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        email TEXT,
        password TEXT,
        noTelp TEXT,
        tanggal TEXT,
        foto TEXT
      )
    ''');
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('daftar.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<Map<String, dynamic>> getUserByEmail(String email) async {
    final db = await SQLHelperProfile.db();
    final List<Map<String, dynamic>> result = await db.query(
      'daftar',
      where: 'email = ?',
      whereArgs: [email],
    );
    return result.isNotEmpty ? result[0] : {};
  }

  static Future<int> editUserByUsername(String username, String email,
      String password, String noTelp, Uint8List foto) async {
    final db = await SQLHelperProfile.db();
    final data = {
      'username': username,
      'email': email,
      'password': password,
      'noTelp': noTelp,
      'foto': foto
    };
    return await db
        .update('daftar', data, where: 'email = ?', whereArgs: [email]);
  }

  static Future<int> addUser(String username, String email, String password,
      String noTelp, String tanggal, Uint8List foto) async {
    final db = await SQLHelperProfile.db();
    final data = {
      'username': username,
      'email': email,
      'password': password,
      'noTelp': noTelp,
      'tanggal': tanggal,
      'foto': foto
    };
    return await db.insert('daftar', data);
  }

  static Future<int> editUser(
    int id,
    String username,
    String email,
    String password,
    String noTelp,
    String tanggal,
  ) async {
    final db = await SQLHelperProfile.db();
    final data = {
      'username': username,
      'email': email,
      'password': password,
      'noTelp': noTelp,
      'tanggal': tanggal,
    };
    return await db.update('daftar', data, where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await SQLHelperProfile.db();
    return db.query('daftar');
  }

  static Future<int> deleteUser(int id) async {
    final db = await SQLHelperProfile.db();
    return await db.delete('daftar', where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> getUser(String email) async {
    final db = await SQLHelperProfile.db();
    return db.query('daftar', where: 'email = ?', whereArgs: [email]);
  }

  static Future<bool> isEmailUnique(String email) async {
    final db = await SQLHelperProfile.db();
    final List<Map<String, dynamic>> result = await db.query(
      'daftar',
      where: 'email = ?',
      whereArgs: [email],
    );
    return result.isEmpty;
  }
}
