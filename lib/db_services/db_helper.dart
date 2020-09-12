import 'dart:io';

import 'package:finance_app/models/txn_data.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final _dbName = 'finance.db';
  static final _dbVersion = 1;
  static final _tableName = 'Transactions';
  static final columnId = '_Id';
  static final columnType = 'Type';
  static final columnAmount = 'Amount';
  static final columnCategory = 'Category';
  static final columnDesc = 'Description';
  static final columnDate = 'Date';
  static final columnTime = 'Time';

  static final _catTableName = 'Category';
  static final catColumnId = '_Id';
  static final catColumnDesc = 'Description';
  static final catColumnBudget = 'Budget';

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initiateDatabase();
    return _database;
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, version) async {
    await db.execute(
        'CREATE TABLE $_tableName($columnId INTEGER PRIMARY KEY,$columnType TEXT NOT NULL,$columnAmount REAL NOT NULL,$columnCategory TEXT,$columnDesc TEXT NOT NULL,$columnDate TEXT NOT NULL, $columnTime TEXT NOT NULL)');
    await db.execute(
        'CREATE TABLE $_catTableName( $catColumnId INTEGER PRIMARY KEY,$catColumnDesc TEXT NOT NULL,$catColumnBudget REAL NOT NULL)');
  }

//  {
//    "_id":12,
//    "name":"AKOMAS"
//  }

  Future<int> insert(TransactionData transaction) async {
    Database db = await instance.database;
    return await db.insert(_tableName, transaction.toMap());
  }

  Future<int> catInsert(TxnCategory category) async {
    Database db = await instance.database;
    return await db.insert(_catTableName, category.toMap2());
  }

  Future<List<TransactionData>> queryAll() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> _maps = await db.query(_tableName);
    return List.generate(_maps.length, (i) {
      return TransactionData(
          txnId: _maps[i][columnId],
          txnDescription: _maps[i][columnDesc],
          txnType: _maps[i][columnType],
          txnAmount: _maps[i][columnAmount],
          txnCategory: _maps[i][columnCategory],
          txnDate: _maps[i][columnDate],
          txnTime: _maps[i][columnTime]);
    });
  }

  Future queryForExpenses(transactionType) async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> _maps = await db.query(_tableName,
        where: '$columnType = ?', whereArgs: [transactionType]);
    return List.generate(_maps.length, (i) {
      return TransactionData(
          txnId: _maps[i][columnId],
          txnDescription: _maps[i][columnDesc],
          txnType: _maps[i][columnType],
          txnAmount: _maps[i][columnAmount],
          txnCategory: _maps[i][columnCategory],
          txnDate: _maps[i][columnDate],
          txnTime: _maps[i][columnTime]);
    });
  }

  Future<List<TransactionData>> queryExpensesByCategory(category) async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> _maps = await db.query(_tableName,
        where: '$columnType = ? and $columnCategory =?',
        whereArgs: ['Expense', category]);
    return List.generate(_maps.length, (i) {
      return TransactionData(
          txnId: _maps[i][columnId],
          txnDescription: _maps[i][columnDesc],
          txnType: _maps[i][columnType],
          txnAmount: _maps[i][columnAmount],
          txnCategory: _maps[i][columnCategory],
          txnDate: _maps[i][columnDate],
          txnTime: _maps[i][columnTime]);
    });
  }

  Future<List<TxnCategory>> catQueryAll() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> _maps = await db.query(_catTableName);
    return List.generate(_maps.length, (i) {
      return TxnCategory(
          id: _maps[i][catColumnId],
          description: _maps[i][catColumnDesc],
          budget: _maps[i][catColumnBudget]);
    });
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db
        .update(_tableName, row, where: '$columnType =?', whereArgs: [id]);
  }

  Future<int> catUpdate(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[catColumnId];
    return await db.update(_catTableName, row,
        where: '$catColumnDesc =?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(_tableName, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> catDelete(int id) async {
    Database db = await instance.database;
    return await db
        .delete(_catTableName, where: '$catColumnId = ?', whereArgs: [id]);
  }
}
