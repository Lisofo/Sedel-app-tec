import 'package:hive/hive.dart';
part 'pto_plaga.g.dart';

@HiveType(typeId: 33)
class PtoPlaga extends HiveObject{
  @HiveField(0)
  late int otPiPlagaId;
  @HiveField(1)
  late int otPuntoInspeccionId;
  @HiveField(2)
  late int plagaId;
  @HiveField(3)
  late String codPlaga;
  @HiveField(4)
  late String descPlaga;
  @HiveField(5)
  late int cantidad;

  PtoPlaga({
    required this.otPiPlagaId,
    required this.otPuntoInspeccionId,
    required this.plagaId,
    required this.codPlaga,
    required this.descPlaga,
    required this.cantidad,
  });

  factory PtoPlaga.fromMap(Map<String, dynamic> json) => PtoPlaga(
        otPiPlagaId: json["otPIPlagaId"] as int? ?? 0,
        otPuntoInspeccionId: json["otPuntoInspeccionId"] as int? ?? 0,
        plagaId: json["plagaId"] as int? ?? 0,
        codPlaga: json["codPlaga"] as String? ?? '',
        descPlaga: json["descPlaga"] as String? ?? '',
        cantidad: json["cantidad"] as int? ?? 0,
      );

  Map<String, dynamic> toMap() => {
        "otPIPlagaId": otPiPlagaId,
        "otPuntoInspeccionId": otPuntoInspeccionId,
        "plagaId": plagaId,
        "codPlaga": codPlaga,
        "descPlaga": descPlaga,
        "cantidad": cantidad,
      };

  PtoPlaga.empty() {
    otPiPlagaId = 0;
    otPuntoInspeccionId = 0;
    plagaId = 0;
    codPlaga = '';
    descPlaga = '';
    cantidad = 0;
  }

  @override
  String toString() {
    return descPlaga;
  }
}