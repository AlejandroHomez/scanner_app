import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';

ScanModels scanModelsFromJson(String str) =>
    ScanModels.fromJson(json.decode(str));

String scanModelsToJson(ScanModels data) => json.encode(data.toJson());

class ScanModels {
  ScanModels({
    this.id,
    this.tipo,
    required this.valor,
  }) {
    if (this.valor.contains('http')) {
      this.tipo = 'http';
    } else {
      this.tipo = 'geo';
    }
  }

  int? id;
  String? tipo;
  String valor;

  LatLng getLatLng() {

    final latLng = this.valor.substring(4).split(',');
    final lat = double.parse( latLng[0]);
    final lng = double.parse( latLng[1]);

    return LatLng(lat, lng);
  }

  factory ScanModels.fromJson(Map<String, dynamic> json) => ScanModels(
        id: json["id"],
        tipo: json["tipo"],
        valor: json["valor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "valor": valor,
      };
}
