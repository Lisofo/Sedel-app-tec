import 'package:hive_flutter/hive_flutter.dart';
part 'pto_material.g.dart';

@HiveType(typeId: 32)
class PtoMaterial extends HiveObject{
  @HiveField(0)
  late int otPiMaterialId;
  @HiveField(1)
  late int otPuntoInspeccionId;
  @HiveField(2)
  late int materialId;
  @HiveField(3)
  late String codMaterial;
  @HiveField(4)
  late String descripcion;
  @HiveField(5)
  late String dosis;
  @HiveField(6)
  late String unidad;
  @HiveField(7)
  late int cantidad;
  @HiveField(8)
  late int? materialLoteId;
  @HiveField(9)
  late String? lote;

  PtoMaterial({
    required this.otPiMaterialId,
    required this.otPuntoInspeccionId,
    required this.materialId,
    required this.codMaterial,
    required this.descripcion,
    required this.dosis,
    required this.unidad,
    required this.cantidad,
    required this.materialLoteId,
    required this.lote,
  });

  factory PtoMaterial.fromMap(Map<String, dynamic> json) => PtoMaterial(
        otPiMaterialId: json["otPIMaterialId"] as int? ?? 0,
        otPuntoInspeccionId: json["otPuntoInspeccionId"] as int? ?? 0,
        materialId: json["materialId"] as int? ?? 0,
        codMaterial: json["codMaterial"] as String? ?? '',
        descripcion: json["descripcion"] as String? ?? '',
        dosis: json["dosis"] as String? ?? '',
        unidad: json["unidad"] as String? ?? '',
        cantidad: json["cantidad"] as int? ?? 0,
        materialLoteId: json["materialLoteId"] as int? ?? 0,
        lote: json["lote"] as String? ?? '',
      );

  Map<String, dynamic> toMap() => {
        "otPIMaterialId": otPiMaterialId,
        "otPuntoInspeccionId": otPuntoInspeccionId,
        "materialId": materialId,
        "codMaterial": codMaterial,
        "descripcion": descripcion,
        "dosis": dosis,
        "unidad": unidad,
        "cantidad": cantidad,
        "materialLoteId": materialLoteId == 0 ? null : materialLoteId,
        "lote": lote,
      };

  PtoMaterial.empty() {
    otPiMaterialId = 0;
    otPuntoInspeccionId = 0;
    materialId = 0;
    codMaterial = '';
    descripcion = '';
    dosis = '';
    unidad = '';
    cantidad = 0;
    materialLoteId = 0;
    lote = '';
  }

  @override
  String toString() {
    return descripcion;
  }
}