import 'dart:convert';
import 'package:hive/hive.dart';
part 'revision_tarea.g.dart';

RevisionTarea tareaFromMap(String str) => RevisionTarea.fromJson(json.decode(str));
String tareaToMap(RevisionTarea data) => json.encode(data.toMap());

@HiveType(typeId: 23)
class RevisionTarea extends HiveObject{
  @HiveField(0)
  late int otTareaId;
  @HiveField(1)
  late int ordenTrabajoId;
  @HiveField(2)
  late int otRevisionId;
  @HiveField(3)
  late int tareaId;
  @HiveField(4)
  late String codTarea;
  @HiveField(5)
  late String descripcion;
  @HiveField(6)
  late String comentario;
  @HiveField(7)
  late int hiveKey;

  RevisionTarea({
    required this.otTareaId,
    required this.ordenTrabajoId,
    required this.otRevisionId,
    required this.tareaId,
    required this.codTarea,
    required this.descripcion,
    required this.comentario,
    required this.hiveKey,
  });

  factory RevisionTarea.fromJson(Map<String, dynamic> json) => RevisionTarea(
        otTareaId: json["otTareaId"] as int? ?? 0,
        ordenTrabajoId: json["ordenTrabajoId"] as int? ?? 0,
        otRevisionId: json["otRevisionId"] as int? ?? 0,
        tareaId: json["tareaId"] as int? ?? 0,
        codTarea: json["codTarea"] as String? ?? '',
        descripcion: json["descripcion"] as String? ?? '',
        comentario: json["comentario"] as String? ?? '',
        hiveKey: 0,
      );

  Map<String, dynamic> toMap() => {
        "otTareaId": otTareaId,
        "ordenTrabajoId": ordenTrabajoId,
        "otRevisionId": otRevisionId,
        "tareaId": tareaId,
        "codTarea": codTarea,
        "descripcion": descripcion,
        "comentario": comentario,
      };

  RevisionTarea.empty() {
    otTareaId = 0;
    ordenTrabajoId = 0;
    otRevisionId = 0;
    tareaId = 0;
    codTarea = '';
    descripcion = '';
    comentario = '';
    hiveKey = 0;
  }

  @override
  String toString() {
    return descripcion;
  }
}
