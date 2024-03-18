import 'dart:convert';
import 'package:hive/hive.dart';
part 'plaga_xtpi.g.dart';

List<PlagaXtpi> plagaXtpiFromMap(String str) => List<PlagaXtpi>.from(json.decode(str).map((x) => PlagaXtpi.fromJson(x)));
String plagaXtpiToMap(List<PlagaXtpi> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

@HiveType(typeId: 17)
class PlagaXtpi extends HiveObject{
  @HiveField(0)
  late int configTpiPlagaId;
  @HiveField(1)
  late int tipoPuntoInspeccionId;
  @HiveField(2)
  late int plagaId;
  @HiveField(3)
  late String codPlaga;
  @HiveField(4)
  late String descripcion;

  PlagaXtpi({
    required this.configTpiPlagaId,
    required this.tipoPuntoInspeccionId,
    required this.plagaId,
    required this.codPlaga,
    required this.descripcion,
  });

  factory PlagaXtpi.fromJson(Map<String, dynamic> json) => PlagaXtpi(
        configTpiPlagaId: json["configTPIPlagaId"] as int? ?? 0,
        tipoPuntoInspeccionId: json["tipoPuntoInspeccionId"] as int? ?? 0,
        plagaId: json["plagaId"] as int? ?? 0,
        codPlaga: json["codPlaga"] as String? ?? '',
        descripcion: json["descripcion"] as String? ?? '',
      );

  Map<String, dynamic> toMap() => {
        "configTPIPlagaId": configTpiPlagaId,
        "tipoPuntoInspeccionId": tipoPuntoInspeccionId,
        "plagaId": plagaId,
        "codPlaga": codPlaga,
        "descripcion": descripcion,
      };

  PlagaXtpi.empty() {
    configTpiPlagaId = 0;
    tipoPuntoInspeccionId = 0;
    plagaId = 0;
    codPlaga = '';
    descripcion = '';
  }
}
