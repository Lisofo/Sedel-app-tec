// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:app_tecnicos_sedel_wifiless/models/revision.dart';
import 'package:hive/hive.dart';

import 'cliente.dart';
import 'servicio_ordenes.dart';
import 'tecnico.dart';
import 'tipo_orden.dart';

part 'orden.g.dart';

List<Orden> ordenFromMap(String str) => List<Orden>.from(json.decode(str).map((x) => Orden.fromJson(x)));

String ordenToMap(List<Orden> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

@HiveType(typeId: 0)
class Orden extends HiveObject {
  @HiveField(0)
  late int ordenTrabajoId;
  @HiveField(1)
  late DateTime fechaOrdenTrabajo;
  @HiveField(2)
  late DateTime fechaDesde;
  @HiveField(3)
  late DateTime fechaHasta;
  @HiveField(4)
  late String instrucciones;
  @HiveField(5)
  late dynamic comentarios;
  @HiveField(6)
  late String estado;
  @HiveField(7)
  late TipoOrden tipoOrden;
  @HiveField(8)
  late Cliente cliente;
  @HiveField(9)
  late Tecnico tecnico;
  @HiveField(10)
  late List<ServicioOrdenes> servicio;
  @HiveField(11)
  late int otRevisionId;
  @HiveField(12)
  late int planoId;
  @HiveField(13)
  late Revision? revision;

  Orden({
    required this.ordenTrabajoId,
    required this.fechaOrdenTrabajo,
    required this.fechaDesde,
    required this.fechaHasta,
    required this.instrucciones,
    required this.comentarios,
    required this.estado,
    required this.tipoOrden,
    required this.cliente,
    required this.tecnico,
    required this.servicio,
    required this.otRevisionId,
    required this.planoId,
    required this.revision,
  });

  factory Orden.fromJson(Map<String, dynamic> json) => Orden(
        ordenTrabajoId: json["ordenTrabajoId"],
        fechaOrdenTrabajo: DateTime.parse(json["fechaOrdenTrabajo"]),
        fechaDesde: DateTime.parse(json["fechaDesde"]),
        fechaHasta: DateTime.parse(json["fechaHasta"]),
        instrucciones: json["instrucciones"] as String? ?? '',
        comentarios: json["comentarios"] as String? ?? '',
        estado: json["estado"],
        tipoOrden: TipoOrden.fromMap(json["tipoOrden"]),
        cliente: Cliente.fromJson(json["cliente"]),
        tecnico: Tecnico.fromJson(json["tecnico"]),
        servicio: List<ServicioOrdenes>.from(json["servicios"].map((x) => ServicioOrdenes.fromJson(x))),
        otRevisionId: json["otRevisionId"] as int? ?? 0,
        planoId: json["planoId"] as int? ?? 0,
        revision: Revision.empty()
      );

  Map<String, dynamic> toMap() => {
        "ordenTrabajoId": ordenTrabajoId,
        "fechaOrdenTrabajo": fechaOrdenTrabajo.toIso8601String(),
        "fechaDesde": fechaDesde.toIso8601String(),
        "fechaHasta": fechaHasta.toIso8601String(),
        "instrucciones": instrucciones,
        "comentarios": comentarios,
        "estado": estado,
        "tipoOrden": tipoOrden.toMap(),
        "cliente": cliente.toMap(),
        "tecnico": tecnico.toMap(),
        "otRevisionId": otRevisionId,
        "planoId": planoId,
      };

  Orden.empty() {
    ordenTrabajoId = 0;
    fechaOrdenTrabajo = DateTime.now();
    fechaDesde = DateTime.now();
    fechaHasta = DateTime.now();
    instrucciones = '';
    comentarios = '';
    estado = '';
    tipoOrden = TipoOrden.empty();
    cliente = Cliente.empty();
    tecnico = Tecnico.empty();
    otRevisionId = 0;
    planoId = 0;
    revision = Revision.empty();
  }
}
