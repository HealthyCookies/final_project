import 'dart:async';
import 'package:sqflite/sqflite.dart';

import '../../../services/database/database_service.dart';
import '../domain/i_database_service.dart';
import '../domain/models/activity.dart';

const String _tableName = 'activity_table';

class ActivityDbService extends DatabaseService
    implements IDatabaseService<Activity> {
  ActivityDbService();

  @override
  FutureOr<void> Function(Database database, int version) get onCreate =>
      (Database database, int version) {
        database.execute('''
          CREATE TABLE IF NOT EXISTS $_tableName(
            id TEXT PRIMARY KEY,
            name TEXT NOT NULL,
            caloriesBurned REAL NOT NULL
          )
        ''');
      };

  @override
  String get tableName => '$_tableName.db';

  @override
  Future<void> insertData(List<Activity> data) async {
    final db = await super.database;
    final batch = db.batch();
    for (final activity in data) {
      batch.insert(
        _tableName,
        activity.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  @override
  Future<void> updateData(List<Activity> data) async {
    final db = await super.database;
    final batch = db.batch();
    for (final activity in data) {
      batch.update(
        _tableName,
        activity.toMap(),
        where: 'id = ?',
        whereArgs: [activity.id],
      );
    }
    await batch.commit(noResult: true);
  }

  @override

  Future<void> deleteData(List<Activity> data) async {
    final db = await super.database;
    final batch = db.batch();
    for (final activity in data) {
      batch.delete(
        _tableName,
        where: 'id = ?',
        whereArgs: [activity.id],
      );
    }
    await batch.commit(noResult: true);
  }

  @override
  Future<List<Activity>> getData(int limit, int offset) async {
    final db = await super.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      limit: limit,
      offset: offset,
    );
    return maps.map((map) => Activity.fromMap(map)).toList();
  }
}
