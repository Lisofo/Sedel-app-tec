import 'dart:convert';
import 'package:hive/hive.dart';
part 'revision_firmas.g.dart';

RevisionFirmas revisionFirmasFromMap(String str) => RevisionFirmas.fromJson(json.decode(str));
String revisionFirmasToMap(RevisionFirmas data) => json.encode(data.toMap());

@HiveType(typeId: 19)
class RevisionFirmas extends HiveObject{
  @HiveField(0)
  late int otFirmaId;
  @HiveField(1)
  late int ordenTrabajoId;
  @HiveField(2)
  late int otRevisionId;
  @HiveField(3)
  late String nombre;
  @HiveField(4)
  late String area;
  @HiveField(5)
  late String firmaPath;
  @HiveField(6)
  late String firmaMd5;
  @HiveField(7)
  late String comentario;

  RevisionFirmas({
    required this.otFirmaId,
    required this.ordenTrabajoId,
    required this.otRevisionId,
    required this.nombre,
    required this.area,
    required this.firmaPath,
    required this.firmaMd5,
    required this.comentario,
  });

  factory RevisionFirmas.fromJson(Map<String, dynamic> json) => RevisionFirmas(
        otFirmaId: json["otFirmaId"]as int? ?? 0,
        ordenTrabajoId: json["ordenTrabajoId"]as int? ?? 0,
        otRevisionId: json["otRevisionId"]as int? ?? 0,
        nombre: json["nombre"]as String? ?? '',
        area: json["area"]as String? ?? '',
        firmaPath: json["firmaPath"]as String? ?? '',
        firmaMd5: json["firmaMD5"]as String? ?? '',
        comentario: json["comentario"]as String? ?? '',
      );

  Map<String, dynamic> toMap() => {
        "otFirmaId": otFirmaId,
        "ordenTrabajoId": ordenTrabajoId,
        "otRevisionId": otRevisionId,
        "nombre": nombre,
        "area": area,
        "firmaPath": firmaPath,
        "firmaMD5": firmaMd5,
        "comentario": comentario,
      };

  RevisionFirmas.empty() {
    otFirmaId = 0;
    ordenTrabajoId = 0;
    otRevisionId = 0;
    nombre = '';
    area = '';
    firmaPath = '';
    firmaMd5 = '';
    comentario = '';
  }
}
