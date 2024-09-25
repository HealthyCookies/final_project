import 'dart:async';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';

import '../../../services/database/database_service.dart';
import '../domain/i_database_service.dart';
import '../domain/models/meal.dart';

const String _tableName = 'meal_table_db';

// ignore: always_specify_types
final mealDbServiceProvider = Provider((_) => MealDbService());

class MealDbService extends DatabaseService implements IDatabaseService<Meal> {
  MealDbService();

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
            fat REAL,
            foods TEXT,
            type TEXT
          )
        ''');
      };

  @override
  String get tableName => '$_tableName.db';

  @override
  Future<void> deleteData(List<Meal> data) async {
    final db = await super.database;
    final batch = db.batch();
    for (final meal in data) {
      batch.delete(
        _tableName,
        where: 'id = ?',
        whereArgs: [meal.id],
      );
    }
    await batch.commit(noResult: true);
  }

  @override
  Future<List<Meal>> getData(int limit, int offset, {String? name}) async {
    final db = await super.database;

    String? where;
    List<dynamic>? whereArgs;

    if (name != null && name.isNotEmpty) {
      where = 'name LIKE ?';
      whereArgs = ['%$name%'];
    }

    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      limit: limit,
      offset: offset,
      where: where,
      whereArgs: whereArgs,
    );
    return maps.map((map) => Meal.fromMap(map)).toList();
  }

  @override
  Future<void> insertData(List<Meal> data) async {
    final db = await super.database;
    final batch = db.batch();
    for (final meal in data) {
      batch.insert(
        _tableName,
        meal.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    try {
      for (final Meal meal in data) {
        log('Trying to insert meal: ${meal.name}');
      }
      await batch.commit(noResult: true);
      log('Success');
    } catch (e) {
      log('Failed');
    }
  }

  @override
  Future<void> updateData(List<Meal> data) async {
    final db = await super.database;
    final batch = db.batch();
    for (final meal in data) {
      batch.update(
        _tableName,
        meal.toMap(),
        where: 'id = ?',
        whereArgs: [meal.id],
      );
    }
    await batch.commit(noResult: true);
  }
}
