import 'package:flutter/material.dart';
import 'package:movies_lister_app/api/movie_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TableConstants {
  static const String tableName = 'moviesWishlistTable';
  static const String id = 'id';
  static const String title = 'title';
  static const String overview = 'overview';
  static const String releaseDate = 'releaseDate';
  static const String backdropPath = 'backdropPath';
  static const String posterPath = 'posterPath';
  static const String voteAverage = 'voteAverage';
  static const String language = 'language';
}

class DatabaseRepository {
  static final DatabaseRepository instance = DatabaseRepository._init();
  DatabaseRepository._init();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase('movies_wishlist.db');
    return _database!;
  }

  Future<Database> _initDatabase(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future _createDatabase(Database db, int version) async {
    await db.execute('''create table ${TableConstants.tableName} (
      ${TableConstants.id} integer primary key not null,
      ${TableConstants.title} text not null,
      ${TableConstants.overview} text not null,
      ${TableConstants.releaseDate} text not null,
      ${TableConstants.backdropPath} text not null,
      ${TableConstants.posterPath} text not null,
      ${TableConstants.voteAverage} real not null,
      ${TableConstants.language} text not null)''');
  }

  Future<void> insert({required Movie movie}) async {
    try {
      final db = await database;
      db.insert(TableConstants.tableName, movie.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<List<Movie>> getWatchlist() async {
    final db = await instance.database;
    final result = await db.query(TableConstants.tableName);
    return result.map((json) => Movie.fromMap(json)).toList();
  }

  Future<bool> doesExists(int id) async {
    final db = await instance.database;
    final result = await db.rawQuery(
        'SELECT EXISTS(SELECT 1 FROM ${TableConstants.tableName} WHERE ${TableConstants.id}=$id)');
    final exists = Sqflite.firstIntValue(result);
    return exists == 1;
  }

  Future<void> delete(int id) async {
    try {
      final db = await instance.database;
      await db.delete(
        TableConstants.tableName,
        where: '${TableConstants.id} = ?',
        whereArgs: [id],
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
