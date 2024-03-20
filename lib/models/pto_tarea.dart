import 'package:hive/hive.dart';
part 'pto_tarea.g.dart';

@HiveType(typeId: 34)
class PtoTarea extends HiveObject{
  @HiveField(0)
  late int otPiTareaId;
  @HiveField(1)
  late int otPuntoInspeccionId;
  @HiveField(2)
  late int tareaId;
  @HiveField(3)
  late String codTarea;
  @HiveField(4)
  late String descTarea;

  PtoTarea({
    required this.otPiTareaId,
    required this.otPuntoInspeccionId,
    required this.tareaId,
    required this.codTarea,
    required this.descTarea,
  });

  factory PtoTarea.fromMap(Map<String, dynamic> json) => PtoTarea(
        otPiTareaId: json["otPITareaId"] as int? ?? 0,
        otPuntoInspeccionId: json["otPuntoInspeccionId"] as int? ?? 0,
        tareaId: json["tareaId"] as int? ?? 0,
        codTarea: json["codTarea"] as String? ?? '',
        descTarea: json["descTarea"] as String? ?? '',
      );

  Map<String, dynamic> toMap() => {
        "otPITareaId": otPiTareaId,
        "otPuntoInspeccionId": otPuntoInspeccionId,
        "tareaId": tareaId,
        "codTarea": codTarea,
        "descTarea": descTarea,
      };

  PtoTarea.empty() {
    otPiTareaId = 0;
    otPuntoInspeccionId = 0;
    tareaId = 0;
    codTarea = '';
    descTarea = '';
  }
}