import 'dart:convert';
import 'package:hive/hive.dart';
part 'revision_plaga.g.dart';

RevisionPlaga revisionPlagaFromMap(String str) => RevisionPlaga.fromJson(json.decode(str));
String revisionPlagaToMap(RevisionPlaga data) => json.encode(data.toMap());

@HiveType(typeId: 21)
class RevisionPlaga extends HiveObject{
  @HiveField(0)
  late int otPlagaId;
  @HiveField(1)
  late int ordenTrabajoId;
  @HiveField(2)
  late int otRevisionId;
  @HiveField(3)
  late String comentario;
  @HiveField(4)
  late int plagaId;
  @HiveField(5)
  late String codPlaga;
  @HiveField(6)
  late String plaga;
  @HiveField(7)
  late int gradoInfestacionId;
  @HiveField(8)
  late String codGradoInfestacion;
  @HiveField(9)
  late String gradoInfestacion;
  @HiveField(10)
  late int hiveKey;

  RevisionPlaga({
    required this.otPlagaId,
    required this.ordenTrabajoId,
    required this.otRevisionId,
    required this.comentario,
    required this.plagaId,
    required this.codPlaga,
    required this.plaga,
    required this.gradoInfestacionId,
    required this.codGradoInfestacion,
    required this.gradoInfestacion,
    required this.hiveKey,
  });

  factory RevisionPlaga.fromJson(Map<String, dynamic> json) => RevisionPlaga(
        otPlagaId: json["otPlagaId"] as int? ?? 0,
        ordenTrabajoId: json["ordenTrabajoId"] as int? ?? 0,
        otRevisionId: json["otRevisionId"] as int? ?? 0,
        comentario: json["comentario"] as String? ?? '',
        plagaId: json["plagaId"] as int? ?? 0,
        codPlaga: json["codPlaga"] as String? ?? '',
        plaga: json["plaga"] as String? ?? '',
        gradoInfestacionId: json["gradoInfestacionId"] as int? ?? 0,
        codGradoInfestacion: json["codGradoInfestacion"] as String? ?? '',
        gradoInfestacion: json["gradoInfestacion"] as String? ?? '',
        hiveKey: 0,
      );

  Map<String, dynamic> toMap() => {
        "otPlagaId": otPlagaId,
        "ordenTrabajoId": ordenTrabajoId,
        "otRevisionId": otRevisionId,
        "comentario": comentario,
        "plagaId": plagaId,
        "codPlaga": codPlaga,
        "plaga": plaga,
        "gradoInfestacionId": gradoInfestacionId,
        "codGradoInfestacion": codGradoInfestacion,
        "gradoInfestacion": gradoInfestacion,
      };

  RevisionPlaga.empty() {
    otPlagaId = 0;
    ordenTrabajoId = 0;
    otRevisionId = 0;
    comentario = '';
    plagaId = 0;
    codPlaga = '';
    plaga = '';
    gradoInfestacionId = 0;
    codGradoInfestacion = '';
    gradoInfestacion = '';
    hiveKey = 0;
  }

  @override
  String toString() {
    return plaga;
  }
}
