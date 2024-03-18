import 'dart:convert';
import 'package:hive/hive.dart';
part 'tipos_ptos_inspeccion.g.dart';

List<TipoPtosInspeccion> tipoPtosInspeccionFromMap(String str) => List<TipoPtosInspeccion>.from(json.decode(str).map((x) => TipoPtosInspeccion.fromJson(x)));
String tipoPtosInspeccionToMap(List<TipoPtosInspeccion> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

@HiveType(typeId: 27)
class TipoPtosInspeccion extends HiveObject {
  @HiveField(0)
  late int tipoPuntoInspeccionId;
  @HiveField(1)
  late String codTipoPuntoInspeccion;
  @HiveField(2)
  late String descripcion;

  TipoPtosInspeccion({
    required this.tipoPuntoInspeccionId,
    required this.codTipoPuntoInspeccion,
    required this.descripcion,
  });

  factory TipoPtosInspeccion.fromJson(Map<String, dynamic> json) =>
      TipoPtosInspeccion(
        tipoPuntoInspeccionId: json["tipoPuntoInspeccionId"],
        codTipoPuntoInspeccion: json["codTipoPuntoInspeccion"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toMap() => {
        "tipoPuntoInspeccionId": tipoPuntoInspeccionId,
        "codTipoPuntoInspeccion": codTipoPuntoInspeccion,
        "descripcion": descripcion,
      };

  TipoPtosInspeccion.empty() {
    tipoPuntoInspeccionId = 0;
    codTipoPuntoInspeccion = '';
    descripcion = '';
  }
}
