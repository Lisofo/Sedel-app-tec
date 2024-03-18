import 'dart:convert';
import 'package:hive/hive.dart';
part 'tarea.g.dart';

List<Tarea> tareaFromMap(String str) => List<Tarea>.from(json.decode(str).map((x) => Tarea.fromJson(x)));
String tareaToMap(List<Tarea> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

@HiveType(typeId: 24)
class Tarea extends HiveObject{
  @HiveField(0)
  late int tareaId;
  @HiveField(1)
  late String codTarea;
  @HiveField(2)
  late String descripcion;

  Tarea({
    required this.tareaId,
    required this.codTarea,
    required this.descripcion,
  });

  factory Tarea.fromJson(Map<String, dynamic> json) => Tarea(
        tareaId: json["tareaId"],
        codTarea: json["codTarea"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toMap() => {
        "tareaId": tareaId,
        "codTarea": codTarea,
        "descripcion": descripcion,
      };

  Tarea.empty() {
    tareaId = 0;
    codTarea = '';
    descripcion = '';
  }

  @override
  String toString() {
    return descripcion;
  }
}
