import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'models/gold_model.dart';

class GoldDatabase {
  GoldDatabase._internal();
  static final GoldDatabase instance = GoldDatabase._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'gold.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE gold_transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        buy_price REAL NOT NULL,
        date TEXT NOT NULL
      )
    ''');
  }

  /// ➕ Add Transaction
  Future<int> addTransaction(GoldTransaction transaction) async {
    final db = await database;
    return await db.insert(
      'gold_transactions',
      transaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// 📥 Get All Transactions
  Future<List<GoldTransaction>> getAllTransactions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'gold_transactions',
      orderBy: 'date DESC',
    );

    return maps.map((e) => GoldTransaction.fromMap(e)).toList();
  }

  /// 🗑 Delete Transaction
  Future<int> deleteTransaction(int id) async {
    final db = await database;
    return await db.delete(
      'gold_transactions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
