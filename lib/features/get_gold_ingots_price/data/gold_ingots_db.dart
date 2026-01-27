import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'gold_ingot_model.dart';

class GoldIngotsDb {
  GoldIngotsDb._internal();
  static final GoldIngotsDb instance = GoldIngotsDb._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'gold_ingots.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE gold_ingots (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        price REAL NOT NULL
      )
    ''');
  }

  /// ➕ Add Ingot
  Future<int> addIngot(GoldIngot ingot) async {
    final db = await database;
    return await db.insert(
      'gold_ingots',
      ingot.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// 📥 Get All Ingots
  Future<List<GoldIngot>> getAllIngots() async {
    final db = await database;
    final result = await db.query('gold_ingots');

    return result.map((e) => GoldIngot.fromMap(e)).toList();
  }

  Future<List<String>> getIngotTitles() async {
    final db = await database;

    final result = await db.query(
      'gold_ingots',
      columns: ['title'], // 👈 only this column
    );

    return result.map((e) => e['title'] as String).toList();
  }

  Future<void> clearIngots() async {
    final db = await database;
    await db.delete('gold_ingots');
  }
}
