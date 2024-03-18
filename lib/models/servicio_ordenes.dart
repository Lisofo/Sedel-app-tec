// ignore_for_file: depend_on_referenced_packages

import 'package:hive/hive.dart';

part 'servicio_ordenes.g.dart';

@HiveType(typeId: 4)
class ServicioOrdenes extends HiveObject {
  @HiveField(0)
  late int servicioId;
  @HiveField(1)
  late String codServicio;
  @HiveField(2)
  late String descripcion;

  ServicioOrdenes({
    required this.servicioId,
    required this.codServicio,
    required this.descripcion,
  });

  factory ServicioOrdenes.fromJson(Map<String, dynamic> json) =>
      ServicioOrdenes(
        servicioId: json["servicioId"],
        codServicio: json["codServicio"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toMap() => {
        "servicioId": servicioId,
        "codServicio": codServicio,
        "descripcion": descripcion,
      };

  ServicioOrdenes.empty() {
    servicioId = 0;
    codServicio = '';
    descripcion = '';
  }
}
