import 'package:hive/hive.dart';
part 'traslado_nuevo.g.dart';

@HiveType(typeId: 35)
class TrasladoNuevo extends HiveObject{
  @HiveField(0)
  late int otPiTrasladoNuevoId;
  @HiveField(1)
  late int otPuntoInspeccionId;
  @HiveField(2)
  late String codPuntoInspeccion;
  @HiveField(3)
  late String codigoBarra;
  @HiveField(4)
  late String zona;
  @HiveField(5)
  late String sector;
  @HiveField(6)
  late int tipoPuntoInspeccionId;
  @HiveField(7)
  late String codTipoPuntoInspeccion;
  @HiveField(8)
  late String tipoPuntoInspeccion;
  @HiveField(9)
  late int plagaObjetivoId;
  @HiveField(10)
  late String codPlagaObjetivo;
  @HiveField(11)
  late String plagaObjetivo;

  TrasladoNuevo({
    required this.otPiTrasladoNuevoId,
    required this.otPuntoInspeccionId,
    required this.codPuntoInspeccion,
    required this.codigoBarra,
    required this.zona,
    required this.sector,
    required this.tipoPuntoInspeccionId,
    required this.codTipoPuntoInspeccion,
    required this.tipoPuntoInspeccion,
    required this.plagaObjetivoId,
    required this.codPlagaObjetivo,
    required this.plagaObjetivo,
  });

  factory TrasladoNuevo.fromMap(Map<String, dynamic> json) => TrasladoNuevo(
        otPiTrasladoNuevoId: json["otPITrasladoNuevoId"] as int? ?? 0,
        otPuntoInspeccionId: json["otPuntoInspeccionId"] as int? ?? 0,
        codPuntoInspeccion: json["codPuntoInspeccion"] as String? ?? '',
        codigoBarra: json["codigoBarra"] as String? ?? '',
        zona: json["zona"] as String? ?? '',
        sector: json["sector"] as String? ?? '',
        tipoPuntoInspeccionId: json["tipoPuntoInspeccionId"] as int? ?? 0,
        codTipoPuntoInspeccion: json["codTipoPuntoInspeccion"] as String? ?? '',
        tipoPuntoInspeccion: json["tipoPuntoInspeccion"] as String? ?? '',
        plagaObjetivoId: json["plagaObjetivoId"] as int? ?? 0,
        codPlagaObjetivo: json["codPlagaObjetivo"] as String? ?? '',
        plagaObjetivo: json["plagaObjetivo"] as String? ?? '',
      );

  Map<String, dynamic> toMap() => {
        "otPITrasladoNuevoId": otPiTrasladoNuevoId,
        "otPuntoInspeccionId": otPuntoInspeccionId,
        "codPuntoInspeccion": codPuntoInspeccion,
        "codigoBarra": codigoBarra,
        "zona": zona,
        "sector": sector,
        "tipoPuntoInspeccionId": tipoPuntoInspeccionId,
        "codTipoPuntoInspeccion": codTipoPuntoInspeccion,
        "tipoPuntoInspeccion": tipoPuntoInspeccion,
        "plagaObjetivoId": plagaObjetivoId,
        "codPlagaObjetivo": codPlagaObjetivo,
        "plagaObjetivo": plagaObjetivo,
      };

  TrasladoNuevo.empty() {
    otPiTrasladoNuevoId = 0;
    otPuntoInspeccionId = 0;
    codPuntoInspeccion = '';
    codigoBarra = '';
    zona = '';
    sector = '';
    tipoPuntoInspeccionId = 0;
    codTipoPuntoInspeccion = '';
    tipoPuntoInspeccion = '';
    plagaObjetivoId = 0;
    codPlagaObjetivo = '';
    plagaObjetivo = '';
  }
}