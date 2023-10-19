import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  //create db
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
      CREATE TABLE pasien(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      name TEXT,
      age INTEGER,
      height DOUBLE,
      weight DOUBLE
      )
    """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('pasien.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
      });
  }

  //insert Employee
  static Future<int> addPasien(String name, int age, double height, double weight) async {
    final db = await SQLHelper.db();
    final data = {'name' : name, 'age' : age, 'height' : height, 'weight' : weight};
    return await db.insert('pasien', data);
  }

  //read Employee
  static Future<List<Map<String, dynamic>>> getPasien() async {
    final db = await SQLHelper.db();
    return db.query('pasien');
  }

  //update Employee
  static Future<int> editPasien(int id, String name, int age, double height, double weight) async {
    final db = await SQLHelper.db();
    final data = {'name' : name, 'age' : age, 'height' : height, 'weight' : weight};
    return await db.update('pasien', data, where: "id = $id");
  }

  //delete Employee
  static Future<int> deletePasien(int id) async {
    final db = await SQLHelper.db();
    return await db.delete('pasien', where: "id = $id");
  }
}

