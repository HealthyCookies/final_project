import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class DatabaseService {
  abstract final FutureOr<void> Function(Database database, int version) onCreate;

  @mustBeOverridden
  String get tableName;

  Database? _db;

  Future<Database> get database async {
    _db ??= await _getDatabase();
    return _db!;
  }

  Future<Database> _getDatabase() async {
    final String dbDirectoryPath = await getDatabasesPath();
    final String dbPath = join(dbDirectoryPath, tableName);
    final Database database = await openDatabase(
      dbPath,
      onCreate: onCreate,
      version: 1,
    );
    return database;
  }
}
