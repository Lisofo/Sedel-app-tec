import 'dart:convert';
import 'package:hive/hive.dart';

import 'pto_material.dart';
import 'pto_plaga.dart';
import 'pto_tarea.dart';
import 'traslado_nuevo.dart';
part 'revision_pto_inspeccion.g.dart';

RevisionPtoInspeccion revisionPtoInspeccionFromMap(String str) => RevisionPtoInspeccion.fromJson(json.decode(str));
String revisionPtoInspeccionToMap(RevisionPtoInspeccion data) => json.encode(data.toMap());

@HiveType(typeId: 22)
class RevisionPtoInspeccion extends HiveObject{
  @HiveField(0)
  late int? otPuntoInspeccionId;
  @HiveField(1)
  late int ordenTrabajoId;
  @HiveField(2)
  late int otRevisionId;
  @HiveField(3)
  late int puntoInspeccionId;
  @HiveField(4)
  late int planoId;
  @HiveField(5)
  late int tipoPuntoInspeccionId;
  @HiveField(6)
  late String codTipoPuntoInspeccion;
  @HiveField(7)
  late String descTipoPuntoInspeccion;
  @HiveField(8)
  late int plagaObjetivoId;
  @HiveField(9)
  late String codPuntoInspeccion;
  @HiveField(10)
  late String codigoBarra;
  @HiveField(11)
  late String zona;
  @HiveField(12)
  late String sector;
  @HiveField(13)
  late int? piAccionId;
  @HiveField(14)
  late String? codAccion;
  @HiveField(15)
  late String? descPiAccion;
  @HiveField(16)
  late String comentario;
  @HiveField(17)
  late List<PtoMaterial> materiales;
  @HiveField(18)
  late List<PtoPlaga> plagas;
  @HiveField(19)
  late List<PtoTarea> tareas;
  @HiveField(20)
  late List<TrasladoNuevo> trasladoNuevo;
  @HiveField(21)
  late int idPIAccion;
  @HiveField(22)
  late bool seleccionado;

  RevisionPtoInspeccion({
    required this.otPuntoInspeccionId,
    required this.ordenTrabajoId,
    required this.otRevisionId,
    required this.puntoInspeccionId,
    required this.planoId,
    required this.tipoPuntoInspeccionId,
    required this.codTipoPuntoInspeccion,
    required this.descTipoPuntoInspeccion,
    required this.plagaObjetivoId,
    required this.codPuntoInspeccion,
    required this.codigoBarra,
    required this.zona,
    required this.sector,
    required this.piAccionId,
    required this.codAccion,
    required this.descPiAccion,
    required this.comentario,
    required this.materiales,
    required this.plagas,
    required this.tareas,
    required this.trasladoNuevo,
    required this.idPIAccion,
    required this.seleccionado,
  });

  factory RevisionPtoInspeccion.fromJson(Map<String, dynamic> json) =>
      RevisionPtoInspeccion(
        otPuntoInspeccionId: json["otPuntoInspeccionId"] as int? ?? 0,
        ordenTrabajoId: json["ordenTrabajoId"] as int? ?? 0,
        otRevisionId: json["otRevisionId"] as int? ?? 0,
        puntoInspeccionId: json["puntoInspeccionId"] as int? ?? 0,
        planoId: json["planoId"] as int? ?? 0,
        tipoPuntoInspeccionId: json["tipoPuntoInspeccionId"] as int? ?? 0,
        codTipoPuntoInspeccion: json["codTipoPuntoInspeccion"] as String? ?? '',
        descTipoPuntoInspeccion:
            json["descTipoPuntoInspeccion"] as String? ?? '',
        plagaObjetivoId: json["plagaObjetivoId"] as int? ?? 0,
        codPuntoInspeccion: json["codPuntoInspeccion"] as String? ?? '',
        codigoBarra: json["codigoBarra"] as String? ?? '',
        zona: json["zona"] as String? ?? '',
        sector: json["sector"] as String? ?? '',
        idPIAccion: json["piAccionId"] as int? ?? 0,
        piAccionId: json["piAccionId"] as int? ?? 0,
        codAccion: json["codAccion"] as String? ?? '',
        descPiAccion: json["desPIAccion"] as String? ?? '',
        comentario: json["comentario"] as String? ?? '',
        materiales: List<PtoMaterial>.from(
            json["materiales"].map((x) => PtoMaterial.fromMap(x))),
        plagas:
            List<PtoPlaga>.from(json["plagas"].map((x) => PtoPlaga.fromMap(x))),
        tareas:
            List<PtoTarea>.from(json["tareas"].map((x) => PtoTarea.fromMap(x))),
        trasladoNuevo: List<TrasladoNuevo>.from(
            json["trasladoNuevo"].map((x) => TrasladoNuevo.fromMap(x))),
        seleccionado: false,
      );

  Map<String, dynamic> toMap() => {
        "otPuntoInspeccionId": otPuntoInspeccionId,
        "ordenTrabajoId": ordenTrabajoId,
        "otRevisionId": otRevisionId,
        "puntoInspeccionId": puntoInspeccionId,
        "planoId": planoId,
        "tipoPuntoInspeccionId": tipoPuntoInspeccionId,
        "codTipoPuntoInspeccion": codTipoPuntoInspeccion,
        "descTipoPuntoInspeccion": descTipoPuntoInspeccion,
        "plagaObjetivoId": plagaObjetivoId,
        "codPuntoInspeccion": codPuntoInspeccion,
        "codigoBarra": codigoBarra,
        "zona": zona,
        "piAccionId": idPIAccion,
        "sector": sector,
        "codAccion": codAccion,
        "desPIAccion": descPiAccion,
        "comentario": comentario,
        "materiales": List<dynamic>.from(materiales.map((x) => x.toMap())),
        "plagas": List<dynamic>.from(plagas.map((x) => x.toMap())),
        "tareas": List<dynamic>.from(tareas.map((x) => x.toMap())),
        "trasladoNuevo":
            List<dynamic>.from(trasladoNuevo.map((x) => x.toMap())),
        "seleccionado": false,
      };

  RevisionPtoInspeccion.empty() {
    otPuntoInspeccionId = 0;
    ordenTrabajoId = 0;
    otRevisionId = 0;
    puntoInspeccionId = 0;
    planoId = 0;
    tipoPuntoInspeccionId = 0;
    codTipoPuntoInspeccion = '';
    descTipoPuntoInspeccion = '';
    plagaObjetivoId = 0;
    codPuntoInspeccion = '';
    codigoBarra = '';
    zona = '';
    sector = '';
    piAccionId = 0;
    codAccion = '';
    descPiAccion = '';
    comentario = '';
    materiales = [];
    plagas = [];
    tareas = [];
    trasladoNuevo = [];
    seleccionado = false;
  }
}