import 'dart:async';

import 'package:sqflite/sqflite.dart';

import '../../../services/database/database_service.dart';
import '../domain/i_database_service.dart';
import '../domain/ingredient_entity.dart';

const String _tableName = 'ingredient_table';

class IngredientProvider extends DatabaseService
    implements IDatabaseService<IngredientEntity> {
  IngredientProvider();

  @override
  FutureOr<void> Function(Database database, int version) get onCreate =>
      (Database database, int version) {
        database.execute('''
            CREATE TABLE IF NOT EXISTS $_tableName(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT NOT NULL
          )
          ''');
      };

  @override
  String get tableName => '$_tableName.db';

  @override
  Future<void> deleteData(List<IngredientEntity> data) async {
    // TODO: implement deleteData
    throw UnimplementedError();
  }

  @override
  Future<List<IngredientEntity>> getData(int limit, int offset) async {
    (await super.database).rawQuery(
      '''
        SELECT * FROM $_tableName
      '''
    );
    // process and return data as List<IngredientEntity>
    throw UnimplementedError();
  }

  @override
  Future<void> insertData(List<IngredientEntity> data) async {
    // TODO: implement insertData
    throw UnimplementedError();
  }

  @override
  Future<void> updateData(List<IngredientEntity> data) async {
    // TODO: implement updateData
    throw UnimplementedError();
  }
}
