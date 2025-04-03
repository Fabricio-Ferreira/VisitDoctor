import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:visit_doctor/core/db_helper/db_update_visit_params.dart';

import 'db_update_client_params.dart';

class DatabaseHelper {
  static const _databaseName = 'granter.db';
  static const _databaseVersion = 1;

  static const tableClient = 'client';
  static const tableVisit = 'visit';
  static const columnIdClient = 'id';
  static const columnName = 'name';
  static const columnAge = 'age';
  static const columnStreet = 'street';
  static const columnCity = 'city';
  static const columnState = 'state';
  static const columnUf = 'uf';
  static const columnNeighborhood = 'neighborhood';
  static const columnNumberHome = 'number_home';
  static const columnZipCode = 'zip_code';
  static const columnComplement = 'complement';
  static const columnReferencePoint = 'reference_point';
  static const columnClientHasVisit = 'has_visit';
  static const columnIdVisit = 'id_visit';
  static const columnReasonVisit = 'reason_visit';
  static const columnDateVisit = 'date_visit';
  static const columnObservationVisit = 'observation_visit';
  static const columnClientName = 'name_client';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  // this opens the database (and creates it if it doesn't exist)
  Future<Database> _initDatabase() async {
    final pathDB = join(await getDatabasesPath(), _databaseName);
    return openDatabase(
      pathDB,
      version: _databaseVersion,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE $tableClient(
            $columnIdClient INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName TEXT NOT NULL,
            $columnAge INTEGER NOT NULL,
            $columnStreet TEXT NOT NULL,
            $columnCity TEXT NOT NULL,
            $columnUf TEXT NOT NULL,
            $columnNeighborhood TEXT NOT NULL,
            $columnNumberHome TEXT NOT NULL,
            $columnZipCode TEXT NOT NULL,
            $columnComplement TEXT,
            $columnReferencePoint TEXT,
            $columnClientHasVisit TEXT
          )
          ''');

        db.execute('''
          CREATE TABLE $tableVisit(
            $columnIdVisit INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnIdClient INTEGER NOT NULL,
            $columnReasonVisit TEXT NOT NULL,
            $columnDateVisit TEXT NOT NULL,
            $columnObservationVisit TEXT,
            $columnClientName TEXT NOT NULL
          )
          ''');
        debugPrint('Database created');
      },
    );
  }

  Future<int> insertClient(Map<String, dynamic> row) async {
    final db = await instance.database;
    return db.insert(tableClient, row);
  }

  Future<List<Map<String, dynamic>>> getAllClients() async {
    final db = await instance.database;
    return db.query(tableClient);
  }

  Future<int> updateClient(DbUpdateClientParams params) async {
    final db = await instance.database;
    final id = params.id;
    final Map<String, dynamic> row = {
      DatabaseHelper.columnName: params.name,
      DatabaseHelper.columnAge: params.age,
      DatabaseHelper.columnNumberHome: params.numberHome,
      DatabaseHelper.columnReferencePoint: params.referencePoint,
      DatabaseHelper.columnClientHasVisit: params.hasVisit,
    };
    return db.update(tableClient, row, where: '$columnIdClient = ?', whereArgs: [id]);
  }

  Future<int> deleteClient(int id) async {
    final db = await instance.database;
    return db.delete(tableClient, where: '$columnIdClient = ?', whereArgs: [id]);
  }

  Future<int> insertVisit(DbUpdateVisitParams params) async {
    final db = await instance.database;
    final Map<String, dynamic> row = {
      DatabaseHelper.columnIdClient: params.clientId,
      DatabaseHelper.columnReasonVisit: params.reasonVisit,
      DatabaseHelper.columnDateVisit: params.dateVisit,
      DatabaseHelper.columnObservationVisit: params.observation,
      DatabaseHelper.columnClientName: params.clientName,
    };

    return db.insert(tableVisit, row);
  }

  Future<List<Map<String, dynamic>>> getAllVisits() async {
    final db = await instance.database;
    return db.query(tableVisit);
  }

  Future<int> updateVisit(DbUpdateVisitParams params) async {
    final db = await instance.database;
    final id = params.visitId;
    final Map<String, dynamic> row = {
      DatabaseHelper.columnIdClient: params.clientId,
      DatabaseHelper.columnIdVisit: params.visitId,
      DatabaseHelper.columnReasonVisit: params.reasonVisit,
      DatabaseHelper.columnDateVisit: params.dateVisit,
      DatabaseHelper.columnObservationVisit: params.observation,
      DatabaseHelper.columnClientName: params.clientName,
    };

    return db.update(tableVisit, row, where: '$columnIdVisit = ?', whereArgs: [id]);
  }

  Future<int> deleteVisit(int id) async {
    final db = await instance.database;
    return db.delete(tableVisit, where: '$columnIdVisit = ?', whereArgs: [id]);
  }

  Future<void> deleteAll() async {
    final db = await instance.database;
    await db.delete(tableClient);
    await db.delete(tableVisit);
  }

  Future<void> close() async {
    final db = await instance.database;
    await db.close();
  }
}
