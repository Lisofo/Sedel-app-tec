import 'dart:convert';
import 'package:app_tecnicos_sedel_wifiless/models/material.dart';
import 'package:app_tecnicos_sedel_wifiless/models/plaga.dart';
import 'package:hive/hive.dart';

import 'lote.dart';
import 'metodo_aplicacion.dart';
part 'revision_materiales.g.dart';

RevisionMaterial revisionMaterialesFromMap(String str) => RevisionMaterial.fromJson(json.decode(str));
String revisionMaterialesToMap(RevisionMaterial data) => json.encode(data.toMap());

@HiveType(typeId: 20)
class RevisionMaterial extends HiveObject {
  @HiveField(0)
  late int otMaterialId;
  @HiveField(1)
  late int ordenTrabajoId;
  @HiveField(2)
  late int otRevisionId;
  @HiveField(3)
  late double cantidad;
  @HiveField(4)
  late String comentario;
  @HiveField(5)
  late String ubicacion;
  @HiveField(6)
  late String areaCobertura;
  @HiveField(7)
  late List<Plaga> plagas;
  @HiveField(8)
  late Materiales material;
  @HiveField(9)
  late Lote lote;
  @HiveField(10)
  late MetodoAplicacion metodoAplicacion;
  @HiveField(11)
  late int hiveKey;

  RevisionMaterial({
    required this.otMaterialId,
    required this.ordenTrabajoId,
    required this.otRevisionId,
    required this.cantidad,
    required this.comentario,
    required this.ubicacion,
    required this.areaCobertura,
    required this.plagas,
    required this.material,
    required this.lote,
    required this.metodoAplicacion,
    required this.hiveKey,
  });

  factory RevisionMaterial.fromJson(Map<String, dynamic> json) =>
      RevisionMaterial(
        otMaterialId: json["otMaterialId"] as int? ?? 0,
        ordenTrabajoId: json["ordenTrabajoId"] as int? ?? 0,
        otRevisionId: json["otRevisionId"] as int? ?? 0,
        cantidad: json["cantidad"]?.toDouble() as double? ?? 0.0,
        comentario: json["comentario"] as String? ?? '',
        ubicacion: json["ubicacion"] as String? ?? '',
        areaCobertura: json["areaCobertura"] as String? ?? '',
        plagas: List<Plaga>.from(json["plagas"].map((x) => Plaga.fromJson(x))),
        material: Materiales.fromJson(json["material"]),
        lote: Lote.fromJson(json["lote"]),
        metodoAplicacion: MetodoAplicacion.fromJson(json["metodoAplicacion"]),
        hiveKey: 0,
      );

  Map<String, dynamic> toMap() => {
        "otMaterialId": otMaterialId,
        "ordenTrabajoId": ordenTrabajoId,
        "otRevisionId": otRevisionId,
        "cantidad": cantidad,
        "comentario": comentario,
        "ubicacion": ubicacion,
        "areaCobertura": areaCobertura,
        "plagas": List<dynamic>.from(plagas.map((x) => x.toMap())),
        "material": material.toMap(),
        "lote": lote.toMap(),
        "metodoAplicacion": metodoAplicacion.toMap(),
      };

  RevisionMaterial.empty() {
    otMaterialId = 0;
    ordenTrabajoId = 0;
    otRevisionId = 0;
    cantidad = 0.0;
    comentario = '';
    ubicacion = '';
    areaCobertura = '';
    plagas = [];
    material = Materiales.empty();
    lote = Lote.empty();
    metodoAplicacion = MetodoAplicacion.empty();
    hiveKey = 0;
  }

  @override
  String toString() {
    return material.descripcion;
  }
}


