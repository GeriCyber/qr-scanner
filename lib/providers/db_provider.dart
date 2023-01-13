import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:qr_reader/models/scan_model.dart';
export 'package:qr_reader/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database> get database async => _database ??= await initDB();

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');

    return await openDatabase(
      path, 
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            type TEXT,
            value TEXT
          )
        ''');
      }
    );
  }

  // Option #1 
  // Prevent SQL injection
  Future<int> newScanRaw(ScanModel newScan) async {
    final id = newScan.id;
    final type = newScan.type;
    final value = newScan.value;

    final db = await database;
    final response = await db.rawInsert('''
      INSERT INTO Scans(id, type, value)
      VALUES($id, $type, $value)
    ''');

    return response;
  }

  // Option #2
  Future<int> newScan(ScanModel newScan) async {
    final db = await database;
    final response = await db.insert('Scans', newScan.toMap());
    return response;
  }

  Future<List<ScanModel>> getScanById(int id) async {
    final db = await database;
    final response = await db.query('Scans', 
      where: 'id = ?', 
      whereArgs: [id]
    );
    return response.isNotEmpty 
    ? response.map((scan) => ScanModel.fromMap(scan)).toList()
    : [];
  }

  Future<List<ScanModel>> getScanByType(String type) async {
    final db = await database;
    final response = await db.query('Scans', 
      where: 'type = ?', 
      whereArgs: [type]
    );
    return response.isNotEmpty 
    ? response.map((scan) => ScanModel.fromMap(scan)).toList()
    : [];
  }

  Future<List<ScanModel>> getAllScans() async {
    final db = await database;
    final response = await db.query('Scans');
    return response.isNotEmpty 
    ? response.map((scan) => ScanModel.fromMap(scan)).toList()
    : [];
  }

  Future<int> updateScan(ScanModel updatedScan) async {
    final db = await database;
    final response = db.update('Scans', updatedScan.toMap(), 
      where: 'id = ?', 
      whereArgs: [updatedScan.id]
    );
    return response;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final response = db.delete('Scans', 
      where: 'id = ?', 
      whereArgs: [id]
    );
    return response;
  }

  Future<int> deleteAllScans() async {
    final db = await database;
    final response = db.delete('Scans');
    return response;
  }
}