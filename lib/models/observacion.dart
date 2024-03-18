import 'dart:convert';
import 'package:hive/hive.dart';
part 'observacion.g.dart';

Observacion observacionFromMap(String str) => Observacion.fromJson(json.decode(str));
String observacionToMap(Observacion data) => json.encode(data.toMap());

@HiveType(typeId: 14)
class Observacion extends HiveObject{
  @HiveField(0)
  late int otObservacionId;
  @HiveField(1)
  late int ordenTrabajoId;
  @HiveField(2)
  late int otRevisionId;
  @HiveField(3)
  late String observacion;
  @HiveField(4)
  late String obsRestringida;
  @HiveField(5)
  late String comentarioInterno;

  Observacion({
    required this.otObservacionId,
    required this.ordenTrabajoId,
    required this.otRevisionId,
    required this.observacion,
    required this.obsRestringida,
    required this.comentarioInterno,
  });

  factory Observacion.fromJson(Map<String, dynamic> json) => Observacion(
        otObservacionId: json["otObservacionId"] as int? ?? 0,
        ordenTrabajoId: json["ordenTrabajoId"] as int? ?? 0,
        otRevisionId: json["otRevisionId"] as int? ?? 0,
        observacion: json["observacion"] as String? ?? '',
        obsRestringida: json["obsRestringida"] as String? ?? '',
        comentarioInterno: json["comentarioInterno"] as String? ?? '',
      );

  Map<String, dynamic> toMap() => {
        "otObservacionId": otObservacionId,
        "ordenTrabajoId": ordenTrabajoId,
        "otRevisionId": otRevisionId,
        "observacion": observacion,
        "obsRestringida": obsRestringida,
        "comentarioInterno": comentarioInterno,
      };

  Observacion.empty() {
    otObservacionId = 0;
    ordenTrabajoId = 0;
    otRevisionId = 0;
    observacion = '';
    obsRestringida = '';
    comentarioInterno = '';
  }
}
