import 'dart:convert';
import 'dart:typed_data';
import 'package:hive/hive.dart';

part 'clientes_firmas.g.dart';

ClienteFirma clienteFirmaFromMap(String str) => ClienteFirma.fromJson(json.decode(str));

String clienteFirmaToMap(ClienteFirma data) => json.encode(data.toMap());

@HiveType(typeId: 7)
class ClienteFirma extends HiveObject{
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
  @HiveField(8)
  late Uint8List? firma;
  @HiveField(9)
  late int hiveKey;

  ClienteFirma({
    required this.otFirmaId,
    required this.ordenTrabajoId,
    required this.otRevisionId,
    required this.nombre,
    required this.area,
    required this.firmaPath,
    required this.firmaMd5,
    required this.comentario,
    required this.firma,
    required this.hiveKey,
  });

  factory ClienteFirma.fromJson(Map<String, dynamic> json) => ClienteFirma(
        otFirmaId: json["otFirmaId"],
        ordenTrabajoId: json["ordenTrabajoId"],
        otRevisionId: json["otRevisionId"],
        nombre: json["nombre"],
        area: json["area"],
        firmaPath: json["firmaPath"],
        firmaMd5: json["firmaMD5"],
        comentario: json["comentario"],
        firma: null,
        hiveKey: 0,
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
        "firma": firma
      };

  ClienteFirma.empty() {
    otFirmaId = 0;
    ordenTrabajoId = 0;
    otRevisionId = 0;
    nombre = '';
    area = '';
    firmaPath = '';
    firmaMd5 = '';
    comentario = '';
    firma = null;
    hiveKey = 0;
  }

  @override
  String toString() {
    return nombre;
  }
}
