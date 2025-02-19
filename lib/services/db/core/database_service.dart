import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/table.dart';

class DatabaseService {
  static Database? _database;
  final String databaseName;
  final int databaseVersion;

  DatabaseService({required this.databaseName, this.databaseVersion = 1});

  Database get database => _database!;

  Future<void> close() async {
    try {
      final db = database;
      await db.close();
    } catch (e) {
      rethrow; // Melemparkan exception kembali jika diperlukan
    }
  }

  Future<void> createTable(Database db, Table table) async {
    try {

      await db.execute(table.sqlDefinition());
    } catch (e) {
      rethrow;
    }
  }

  Future<int> delete(
    String tableName, {
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    try {
      final db = database;
      return await db.delete(
        tableName,
        where: where,
        whereArgs: whereArgs,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> init() async {
    try {
      _database = await initDatabase();
    } catch (e) {
      rethrow;
    }
  }

  Future<Database> initDatabase() async {
    try {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, databaseName);
      return await openDatabase(
        path,
        version: databaseVersion,
        onCreate: (Database database, int version) {

          onCreate(database, version);
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<int> insert(String tableName, Map<String, dynamic> data) async {
    try {
      final db = database;
      return await db.insert(tableName, data);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> isTableExists(String tableName) async {
    final db = database;
    return await db
        .rawQuery(
            "SELECT * FROM sqlite_master WHERE type='table' AND name = '$tableName'")
        .then((value) => value.isNotEmpty);
  }

  Future<void> onCreate(Database db, int version) async {
    try {
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> query(
    String tableName, {
    String? where,
    List<dynamic>? whereArgs,
    String? orderBy,
    int? limit,
  }) async {
    try {
      final db = database;
      print(
          "Querying data ON DATABASE SERVICE for table: $tableName on DB: $db");
      return await db.query(
        tableName,
        where: where,
        whereArgs: whereArgs,
        orderBy: orderBy,
        limit: limit,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<int> update(
    String tableName,
    Map<String, dynamic> data, {
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    try {
      final db = database;
      return await db.update(
        tableName,
        data,
        where: where,
        whereArgs: whereArgs,
      );
    } catch (e) {
      rethrow;
    }
  }
}