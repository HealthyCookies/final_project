import 'dart:async';

import 'package:sqflite/sqflite.dart';

import '../../../services/database/database_service.dart';
import '../domain/i_database_service.dart';
import '../domain/models/ingredient.dart';

const String _tableName = 'ingredient_table_db';

class IngredientDbService extends DatabaseService
    implements IDatabaseService<Ingredient> {
  IngredientDbService();

  @override
  FutureOr<void> Function(Database database, int version) get onCreate =>
      (Database database, int version) {
        database.execute('''
          CREATE TABLE IF NOT EXISTS $_tableName(
            id TEXT PRIMARY KEY,
            name TEXT NOT NULL
          )
        ''');
      };

  @override
  String get tableName => '$_tableName.db';

  @override
  Future<void> deleteData(List<Ingredient> data) async {
    final db = await super.database;
    final batch = db.batch();
    for (final ingredient in data) {
      batch.delete(
        _tableName,
        where: 'id = ?',
        whereArgs: [ingredient.id],
      );
    }
    await batch.commit(noResult: true);
  }

  @override
  Future<List<Ingredient>> getData(int limit, int offset) async {
    final db = await super.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      limit: limit,
      offset: offset,
    );
    return maps.map((map) => Ingredient.fromMap(map)).toList();
  }

  @override
  Future<void> insertData(List<Ingredient> data) async {
    final db = await super.database;
    final batch = db.batch();
    for (final ingredient in data) {
      batch.insert(
        _tableName,
        ingredient.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  @override
  Future<void> updateData(List<Ingredient> data) async {
    final db = await super.database;
    final batch = db.batch();
    for (final ingredient in data) {
      batch.update(
        _tableName,
        ingredient.toMap(),
        where: 'id = ?',
        whereArgs: [ingredient.id],
      );
    }
    await batch.commit(noResult: true);
  }
}
