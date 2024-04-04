import 'dart:convert';
import 'package:hive/hive.dart';
part 'marcas.g.dart';

List<Marca> marcaFromMap(String str) => List<Marca>.from(json.decode(str).map((x) => Marca.fromJson(x)));
String marcaToMap(List<Marca> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

@HiveType(typeId: 12)
class Marca extends HiveObject{
  @HiveField(0)
  late int marcaId;
  @HiveField(1)
  late DateTime desde;
  @HiveField(2)
  late DateTime? hasta;
  @HiveField(3)
  late int tecnicoId;
  @HiveField(4)
  late String codTecnico;
  @HiveField(5)
  late String nombreTecnico;
  @HiveField(6)
  late int? ubicacionId;
  @HiveField(7)
  late String? ubicacion;
  @HiveField(8)
  late int? ubicacionIdHasta;
  @HiveField(9)
  late String? ubicacionHasta;

  Marca({
    required this.marcaId,
    required this.desde,
    required this.hasta,
    required this.tecnicoId,
    required this.codTecnico,
    required this.nombreTecnico,
    required this.ubicacionId,
    required this.ubicacion,
    required this.ubicacionIdHasta,
    required this.ubicacionHasta,
  });

  factory Marca.fromJson(Map<String, dynamic> json) => Marca(
        marcaId: json["marcaId"],
        desde: DateTime.parse(json["desde"]),
        hasta: json["hasta"] == null ? null : DateTime.parse(json["hasta"]),
        tecnicoId: json["tecnicoId"],
        codTecnico: json["codTecnico"] ?? '',
        nombreTecnico: json["nombreTecnico"] ?? '',
        ubicacionId: json["ubicacionId"],
        ubicacion: json["ubicacion"] ?? '',
        ubicacionIdHasta: json["ubicacionIdHasta"],
        ubicacionHasta: json["ubicacionHasta"] ?? ''  ,
      );

  Map<String, dynamic> toMap() => {
        "marcaId": marcaId,
        "desde": _formatDateAndTime(desde),
        "hasta": hasta != null ? _formatDateAndTime(hasta) : null,
        "tecnicoId": tecnicoId,
        "codTecnico": codTecnico,
        "nombreTecnico": nombreTecnico,
        "ubicacionId": ubicacionId,
        "ubicacion": ubicacion,
        "ubicacionIdHasta": ubicacionIdHasta,
        "ubicacionHasta": ubicacionHasta,
      };
  Map<String, dynamic> toJson() => {
        "marcaId": marcaId,
        "desde": _formatDateAndTime(desde),
        "hasta": hasta != null ? _formatDateAndTime(hasta) : null,
        "tecnicoId": tecnicoId,
        "codTecnico": codTecnico,
        "nombreTecnico": nombreTecnico,
        "ubicacionId": ubicacionId,
        "ubicacion": ubicacion,
        "ubicacionIdHasta": ubicacionIdHasta,
        "ubicacionHasta": ubicacionHasta,
      };

  String _formatDateAndTime(DateTime? date) {
    return '${date?.year.toString().padLeft(4, '0')}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}T${date?.hour.toString().padLeft(2, '0')}:${date?.minute.toString().padLeft(2, '0')}:${date?.second.toString().padLeft(2, '0')}';
  }

  Marca.empty() {
    marcaId = 0;
    desde = DateTime.now();
    hasta = null;
    tecnicoId = 0;
    codTecnico = '';
    nombreTecnico = '';
    ubicacionId = 0;
    ubicacion = '';
    ubicacionIdHasta = 0;
    ubicacionHasta = '';
  }

  @override
  String toString() {
    return '{"marcaId": $marcaId,"desde":"$desde", "tecnicoId": $tecnicoId, "ubicacionId":$ubicacionId}';
  }
}
