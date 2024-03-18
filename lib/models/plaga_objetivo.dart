import 'dart:convert';
import 'package:hive/hive.dart';
part 'plaga_objetivo.g.dart';

List<PlagaObjetivo> plagaObjetivoFromMap(String str) => List<PlagaObjetivo>.from(json.decode(str).map((x) => PlagaObjetivo.fromJson(x)));
String plagaObjetivoToMap(List<PlagaObjetivo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

@HiveType(typeId: 15)
class PlagaObjetivo extends HiveObject{
  @HiveField(0)
  late int plagaObjetivoId;
  @HiveField(1)
  late String codPlagaObjetivo;
  @HiveField(2)
  late String descripcion;
  @HiveField(3)
  late dynamic fechaBaja;

  PlagaObjetivo({
    required this.plagaObjetivoId,
    required this.codPlagaObjetivo,
    required this.descripcion,
    required this.fechaBaja,
  });

  factory PlagaObjetivo.fromJson(Map<String, dynamic> json) => PlagaObjetivo(
        plagaObjetivoId: json["plagaObjetivoId"] as int? ?? 0,
        codPlagaObjetivo: json["codPlagaObjetivo"] as String? ?? '',
        descripcion: json["descripcion"] as String? ?? '',
        fechaBaja: json["fechaBaja"] as String? ?? '',
      );

  Map<String, dynamic> toMap() => {
        "plagaObjetivoId": plagaObjetivoId,
        "codPlagaObjetivo": codPlagaObjetivo,
        "descripcion": descripcion,
        "fechaBaja": fechaBaja,
      };

  PlagaObjetivo.empty() {
    plagaObjetivoId = 0;
    codPlagaObjetivo = '';
    descripcion = '';
    fechaBaja = '';
  }
}
