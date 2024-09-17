import 'package:exam_project/core/models/budget.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  Database? _database;
  final _tableName = "budgets";
  Future<Database> get database async {
    if (_database != null) {
      _database;
    }

    return await initialize();
  }

  Future<Database> initialize() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, "budgets.db");
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: _createDatabase,
    );
    return database;
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        date INTEGER,
        amount NUM,
        category TEXT,
        isIncome INTEGER
        )
      ''');
  }

  Future<void> addBudget(Budget budget) async {
    final db = await database;

    final res = await db.insert(_tableName, budget.toMap());
    print("Add budget is ==============> $res");
  }

  Future<void> deleteBudget(int id) async {
    final db = await database;

    final res = await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    print("Delete budget is ==============> $res");
  }

  Future<void> updateBudget(Budget budget) async {
    final db = await database;

    final res = await db.update(
      _tableName,
      budget.toMap(),
      where: 'id = ?',
      whereArgs: [budget.id],
    );
    print("Update budget is ==============> $res");
  }

  Future<List<Budget>> getBudgets() async {
    final db = await database;

    final res = await db.query(_tableName);
    List<Budget> budgets = [];

    for (var element in res) {
      budgets.add(
        Budget.fromMap(element),
      );
    }
    return budgets;
  }

  Future<void> getByCategory(String category) async {
    final db = await database;

    await db.query(_tableName, where: 'category = ?', whereArgs: [category]);
  }
}
