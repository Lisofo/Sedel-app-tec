import 'dart:convert';
import 'package:hive/hive.dart';

part 'control_orden.g.dart';

List<ControlOrden> controlOrdenFromMap(String str) => List<ControlOrden>.from(json.decode(str).map((x) => ControlOrden.fromJson(x)));
String controlOrdenToMap(List<ControlOrden> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

@HiveType(typeId: 8)
class ControlOrden extends HiveObject{
    @HiveField(0)
    late int controlRegId;
    @HiveField(1)
    late int ordenTrabajoId;
    @HiveField(2)
    late int controlId;
    @HiveField(3)
    late int ordinal;
    @HiveField(4)
    late String respuesta;
    @HiveField(5)
    late String comentario;
    @HiveField(6)
    late String grupo;
    @HiveField(7)
    late String pregunta;

    ControlOrden({
        required this.controlRegId,
        required this.ordenTrabajoId,
        required this.controlId,
        required this.ordinal,
        required this.respuesta,
        required this.comentario,
        required this.grupo,
        required this.pregunta,
    });

    factory ControlOrden.fromJson(Map<String, dynamic> json) => ControlOrden(
        controlRegId: json["controlRegId"] as int? ?? 0,
        ordenTrabajoId: json["ordenTrabajoId"] as int? ?? 0,
        controlId: json["controlId"] as int? ?? 0,
        ordinal: json["ordinal"] as int? ?? 0,
        respuesta: json["respuesta"] as String? ?? '',
        comentario: json["comentario"] as String? ?? '',
        grupo: json["grupo"] as String? ?? '',
        pregunta: json["pregunta"] as String? ?? '',
    );

    Map<String, dynamic> toMap() => {
        "controlRegId": controlRegId,
        "ordenTrabajoId": ordenTrabajoId,
        "controlId": controlId,
        "ordinal": controlId,
        "respuesta": respuesta,
        "comentario": comentario,
        "grupo": grupo,
        "pregunta": pregunta,
    };

    ControlOrden.empty(){
      controlRegId = 0;
      ordenTrabajoId = 0;
      controlId = 0;
      ordinal = 0;
      respuesta = '';
      comentario = '';
      grupo = '';
      pregunta = '';
    }
}
