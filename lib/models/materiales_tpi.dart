import 'dart:convert';
import 'package:hive/hive.dart';
part 'materiales_tpi.g.dart';

List<MaterialXtpi> materialesXtpiFromMap(String str) => List<MaterialXtpi>.from(json.decode(str).map((x) => MaterialXtpi.fromJson(x)));
String materialesXtpiToMap(List<MaterialXtpi> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

@HiveType(typeId: 13)
class MaterialXtpi extends HiveObject{
  @HiveField(0)
  late int configTpiMaterialId;
  @HiveField(1)
  late int tipoPuntoInspeccionId;
  @HiveField(2)
  late int materialId;
  @HiveField(3)
  late String codMaterial;
  @HiveField(4)
  late String descripcion;
  @HiveField(5)
  late String unidad;
  @HiveField(6)
  late String dosis;

  MaterialXtpi({
    required this.configTpiMaterialId,
    required this.tipoPuntoInspeccionId,
    required this.materialId,
    required this.codMaterial,
    required this.descripcion,
    required this.unidad,
    required this.dosis,
  });

  factory MaterialXtpi.fromJson(Map<String, dynamic> json) => MaterialXtpi(
        configTpiMaterialId: json["configTPIMaterialId"] as int? ?? 0,
        tipoPuntoInspeccionId: json["tipoPuntoInspeccionId"] as int? ?? 0,
        materialId: json["materialId"] as int? ?? 0,
        codMaterial: json["codMaterial"] as String? ?? '',
        descripcion: json["descripcion"] as String? ?? '',
        unidad: json["unidad"] as String? ?? '',
        dosis: json["dosis"] as String? ?? '',
      );

  Map<String, dynamic> toMap() => {
        "configTPIMaterialId": configTpiMaterialId,
        "tipoPuntoInspeccionId": tipoPuntoInspeccionId,
        "materialId": materialId,
        "codMaterial": codMaterial,
        "descripcion": descripcion,
        "unidad": unidad,
        "dosis": dosis,
      };

  MaterialXtpi.empty() {
    configTpiMaterialId = 0;
    tipoPuntoInspeccionId = 0;
    materialId = 0;
    codMaterial = '';
    descripcion = '';
    unidad = '';
    dosis = '';
  }
}
