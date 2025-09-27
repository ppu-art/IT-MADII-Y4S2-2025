// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
//
// class DBManager {
//   final String _dbName = "ppua.db";
//
//   static final DBManager instance = DBManager._init();
//
//   DBManager._init();
//
//   Future<Database> get database async {
//     // Get Current Path
//     final dbPath = await getDatabasesPath();
//     // Create DB Path
//     final path = join(dbPath, _dbName);
//     return openDatabase(path, version: 1, onCreate: _onCreate);
//   }
//
//   Future<void> _onCreate(Database db, int version) async {
//     String idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
//     String textType = "TEXT";
//
//     await db.execute('''
//       CREATE TABLE IF NOT EXISTS tb_menu(
//       id $idType,
//       title $textType,
//       description $textType
//       );
//     ''');
//
//     await db.execute('''
//       CREATE TABLE IF NOT EXISTS tb_news(
//       id $idType,
//       title $textType,
//       content $textType
//       );
//     ''');
//   }
// }
