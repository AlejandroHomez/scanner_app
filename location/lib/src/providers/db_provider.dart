import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:location/src/models/scan_models.dart';
export 'package:location/src/models/scan_models.dart';

class DBProvider {
  static Database? _dataBase;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get dataBase async {
    if (_dataBase != null) return _dataBase!;

    _dataBase = await initDB();

    return _dataBase!;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');

    print(path);

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
              CREATE TABLE Scans(
                id INTEGER PRIMARY KEY,
                tipo TEXT,
                valor TEXT
              )
            ''');
    });
  }

  // Future<int> nuevoScanRaw(ScanModels nuevoScan) async {
  //   final id = nuevoScan.id;
  //   final tipo = nuevoScan.tipo;
  //   final valor = nuevoScan.valor;

  //   final db = await dataBase;

  //   final res = await db.rawInsert('''
  //   INSERT INTO Scans(id, tipo, valor)
  //    VALUES($id, '$tipo' , '$valor')
  //   ''');

  //   return res;
  // }

  Future<int> nuevoScan(ScanModels nuevoScan) async {
    final db = await dataBase;
    final res = await db.insert('Scans', nuevoScan.toJson());

    return res;
  }

  Future<ScanModels?> getScanById(int id) async {
    final db = await dataBase;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? ScanModels.fromJson(res.first) : null;
  }

  Future<List<ScanModels>?> getTodosScans() async {
    final db = await dataBase;
    final res = await db.query('Scans');

    return res.isNotEmpty
        ? res.map((s) => ScanModels.fromJson(s)).toList()
        : [];
  }

  Future<List<ScanModels>?> getScansPorTipo(String tipo) async {
    final db = await dataBase;
    final res = await db.rawQuery('''
    SELECT * FROM Scans WHERE tipo = '$tipo'
    ''');

    return res.isNotEmpty
        ? res.map((e) => ScanModels.fromJson(e)).toList()
        : [];
  }

  Future<int> updateScan(ScanModels nuevoScan) async {
    final db = await dataBase;
    final res = await db.update('Scans', nuevoScan.toJson(),
        where: 'id= ?', whereArgs: [nuevoScan.id]);

    return res;
  }

  Future<int> deleteScan(int id) async {
    final db = await dataBase;
    final res = db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllScans() async {
    final db = await dataBase;
    final res = db.delete('Scans');
    return res;
  }
}
