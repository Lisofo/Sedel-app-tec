// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:hive/hive.dart';
part 'material.g.dart';

List<Materiales> materialFromMap(String str) => List<Materiales>.from(json.decode(str).map((x) => Materiales.fromJson(x)));
String materialToMap(List<Materiales> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

@HiveType(typeId: 5)
class Materiales extends HiveObject {
  @HiveField(0)
  late int materialId;
  @HiveField(1)
  late String codMaterial;
  @HiveField(2)
  late String descripcion;
  @HiveField(3)
  late String dosis;
  @HiveField(4)
  late String unidad;
  @HiveField(5)
  late String fabProv;
  @HiveField(6)
  late String enAppTecnico;
  @HiveField(7)
  late String enUso;

  Materiales({
    required this.materialId,
    required this.codMaterial,
    required this.descripcion,
    required this.dosis,
    required this.unidad,
    required this.fabProv,
    required this.enAppTecnico,
    required this.enUso,
  });

  factory Materiales.fromJson(Map<String, dynamic> json) => Materiales(
        materialId: json["materialId"] as int? ?? 0,
        codMaterial: json["codMaterial"] as String? ?? '',
        descripcion: json["descripcion"] as String? ?? '',
        dosis: json["dosis"] as String? ?? '',
        unidad: json["unidad"] as String? ?? '',
        fabProv: json["fabProv"] as String? ?? '',
        enAppTecnico: json["enAppTecnico"] as String? ?? '',
        enUso: json["enUso"] as String? ?? '',
      );

  Map<String, dynamic> toMap() => {
        "materialId": materialId,
        "codMaterial": codMaterial,
        "descripcion": descripcion,
        "dosis": dosis,
        "unidad": unidad,
        "fabProv": fabProv,
        "enAppTecnico": enAppTecnico,
        "enUso": enUso,
      };

  Materiales.empty() {
    materialId = 0;
    codMaterial = '';
    descripcion = '';
    dosis = '';
    unidad = '';
    fabProv = '';
    enAppTecnico = '';
    enUso = '';
  }

  @override
  String toString() {
    return descripcion;
  }
}
