import 'dart:convert';
import 'package:hive/hive.dart';
part 'tarea_xtpi.g.dart';

List<TareaXtpi> tareaXtpiFromMap(String str) => List<TareaXtpi>.from(json.decode(str).map((x) => TareaXtpi.fromJson(x)));
String tareaXtpiToMap(List<TareaXtpi> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

@HiveType(typeId: 25)
class TareaXtpi extends HiveObject{
  @HiveField(0)
  late int configTpiTareaId;
  @HiveField(1)
  late int tipoPuntoInspeccionId;
  @HiveField(2)
  late String modo;
  @HiveField(3)
  late int tareaId;
  @HiveField(4)
  late String codTarea;
  @HiveField(5)
  late String descripcion;
  @HiveField(6)
  late bool selected;

  TareaXtpi(
      {required this.configTpiTareaId,
      required this.tipoPuntoInspeccionId,
      required this.modo,
      required this.tareaId,
      required this.codTarea,
      required this.descripcion,
      required this.selected});

  factory TareaXtpi.fromJson(Map<String, dynamic> json) => TareaXtpi(
      configTpiTareaId: json["configTPITareaId"],
      tipoPuntoInspeccionId: json["tipoPuntoInspeccionId"],
      modo: json["modo"],
      tareaId: json["tareaId"],
      codTarea: json["codTarea"],
      descripcion: json["descripcion"],
      selected: false);

  Map<String, dynamic> toMap() => {
        "configTPITareaId": configTpiTareaId,
        "tipoPuntoInspeccionId": tipoPuntoInspeccionId,
        "modo": modo,
        "tareaId": tareaId,
        "codTarea": codTarea,
        "descripcion": descripcion,
        "selected": false,
      };
}
