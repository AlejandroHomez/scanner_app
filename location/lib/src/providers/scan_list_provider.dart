import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:location/src/providers/db_provider.dart';

class ScanListProvier extends ChangeNotifier {
  List<ScanModels> scans = [];

  String tipoSeleccionado = 'http';

  Future<ScanModels> nuevoScan(String valor) async {
    final nuevoScan = new ScanModels(valor: valor);
    final id = await DBProvider.db.nuevoScan(nuevoScan);

    nuevoScan.id = id;

    if (this.tipoSeleccionado == nuevoScan.tipo) {
      this.scans.add(nuevoScan);
      notifyListeners();
    }

    return nuevoScan;
  }

  cargarScans() async {
    final scans = await DBProvider.db.getTodosScans();
    this.scans = [...scans!];
    notifyListeners();
  }

  cargarScansPorTipo(String tipo) async {
    Future.delayed(Duration(seconds: 2));

    final scans = await DBProvider.db.getScansPorTipo(tipo);
    this.scans = [...scans!];
    this.tipoSeleccionado = tipo;
    notifyListeners();
  }

  borrarTodos() async {
    await DBProvider.db.deleteAllScans();
    this.scans = [];
    notifyListeners();
  }

  borraScanById(int id) async {
    await DBProvider.db.deleteScan(id);
  }
}
