import 'dart:async';

import 'package:sqflite/sqflite.dart';

import '../../../services/database/database_service.dart';
import '../domain/i_database_service.dart';
import '../domain/models/food.dart';

const String _tableName = 'food_table';

class FoodDbService extends DatabaseService implements IDatabaseService<Food> {
  FoodDbService();

  @override
  FutureOr<void> Function(Database database, int version) get onCreate =>
      (Database database, int version) {
        database.execute('''
          CREATE TABLE IF NOT EXISTS $_tableName(
            id TEXT PRIMARY KEY,
            name TEXT NOT NULL,
            calories REAL NOT NULL,
            carbs REAL,
            protein REAL,
            fat REAL
          )
        ''');
      };

  @override
  String get tableName => '$_tableName.db';

  @override
  Future<void> deleteData(List<Food> data) async {
    final db = await super.database;
    final batch = db.batch();
    for (final food in data) {
      batch.delete(
        _tableName,
        where: 'id = ?',
        whereArgs: [food.id],
      );
    }
    await batch.commit(noResult: true);
  }

  @override
  Future<List<Food>> getData(int limit, int offset, {String? name}) async {
    final db = await super.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      limit: limit,
      offset: offset,
    );
    return maps.map((map) => Food.fromMap(map)).toList();
  }

  @override
  Future<void> insertData(List<Food> data) async {
    final db = await super.database;
    final batch = db.batch();
    for (final food in data) {
      batch.insert(
        _tableName,
        food.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  @override
  Future<void> updateData(List<Food> data) async {
    final db = await super.database;
    final batch = db.batch();
    for (final food in data) {
      batch.update(
        _tableName,
        food.toMap(),
        where: 'id = ?',
        whereArgs: [food.id],
      );
    }
    await batch.commit(noResult: true);
  }
}
