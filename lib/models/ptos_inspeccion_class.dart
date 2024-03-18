import 'dart:convert';
import 'package:hive/hive.dart';
part 'ptos_inspeccion_class.g.dart';

List<PtosInspeccion> ptosInspeccionFromMap(String str) =>  List<PtosInspeccion>.from(json.decode(str).map((x) => PtosInspeccion.fromJson(x)));
String ptosInspeccionToMap(List<PtosInspeccion> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

@HiveType(typeId: 18)
class PtosInspeccion extends HiveObject{
  @HiveField(0)
  late int puntoInspeccionId;
  @HiveField(1)
  late int planoId;
  @HiveField(2)
  late String codPuntoInspeccion;
  @HiveField(3)
  late String zona;
  @HiveField(4)
  late String sector;
  @HiveField(5)
  late String codigoBarra;
  @HiveField(6)
  late int tipoPuntoInspeccionId;
  @HiveField(7)
  late String codTipoPuntoInspeccion;
  @HiveField(8)
  late String descTipoPunto;
  @HiveField(9)
  late int plagaObjetivoId;
  @HiveField(10)
  late String codPlagaObjetivo;
  @HiveField(11)
  late String descPlagaObjetivo;
  @HiveField(12)
  late DateTime desde;
  @HiveField(13)
  late String estado;
  @HiveField(14)
  late String subEstado;
  @HiveField(15)
  late String comentario;
  @HiveField(16)
  late bool seleccionado;

  PtosInspeccion({
    required this.puntoInspeccionId,
    required this.planoId,
    required this.codPuntoInspeccion,
    required this.zona,
    required this.sector,
    required this.codigoBarra,
    required this.tipoPuntoInspeccionId,
    required this.codTipoPuntoInspeccion,
    required this.descTipoPunto,
    required this.plagaObjetivoId,
    required this.codPlagaObjetivo,
    required this.descPlagaObjetivo,
    required this.desde,
    required this.estado,
    required this.subEstado,
    required this.comentario,
    required this.seleccionado
  });

  factory PtosInspeccion.fromJson(Map<String, dynamic> json) => PtosInspeccion(
        puntoInspeccionId: json["puntoInspeccionId"],
        planoId: json["planoId"],
        codPuntoInspeccion: json["codPuntoInspeccion"],
        zona: json["zona"],
        sector: json["sector"],
        codigoBarra: json["codigoBarra"],
        tipoPuntoInspeccionId: json["tipoPuntoInspeccionId"],
        codTipoPuntoInspeccion: json["codTipoPuntoInspeccion"],
        descTipoPunto: json["descTipoPunto"],
        plagaObjetivoId: json["plagaObjetivoId"],
        codPlagaObjetivo: json["codPlagaObjetivo"],
        descPlagaObjetivo: json["descPlagaObjetivo"],
        desde: DateTime.parse(json["desde"]),
        estado: json["estado"],
        subEstado: json["subEstado"],
        comentario: json["comentario"],
        seleccionado: false,
      );

  Map<String, dynamic> toMap() => {
        "puntoInspeccionId": puntoInspeccionId,
        "planoId": planoId,
        "codPuntoInspeccion": codPuntoInspeccion,
        "zona": zona,
        "sector": sector,
        "codigoBarra": codigoBarra,
        "tipoPuntoInspeccionId": tipoPuntoInspeccionId,
        "codTipoPuntoInspeccion": codTipoPuntoInspeccion,
        "descTipoPunto": descTipoPunto,
        "plagaObjetivoId": plagaObjetivoId,
        "codPlagaObjetivo": codPlagaObjetivo,
        "descPlagaObjetivo": descPlagaObjetivo,
        "desde": desde.toIso8601String(),
        "estado": estado,
        "subEstado": subEstado,
        "comentario": comentario,
      };

  PtosInspeccion.empty() {
    puntoInspeccionId = 0;
    planoId = 0;
    codPuntoInspeccion = '';
    zona = '';
    sector = '';
    codigoBarra = '';
    tipoPuntoInspeccionId = 0;
    codTipoPuntoInspeccion = '';
    descTipoPunto = '';
    plagaObjetivoId = 0;
    codPlagaObjetivo = '';
    descPlagaObjetivo = '';
    desde = DateTime.now();
    estado = '';
    subEstado = '';
    comentario = '';
  }
}
