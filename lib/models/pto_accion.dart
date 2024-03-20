import 'package:hive/hive.dart';
part 'pto_accion.g.dart';

@HiveType(typeId: 36) 
class PtoAccion extends HiveObject{
  @HiveField(0)
  late int piAccionId;
  @HiveField(1)
  late String codAccion;
  @HiveField(2)
  late String descPiAccion;

  PtoAccion({
    required this.piAccionId,
    required this.codAccion,
    required this.descPiAccion,
  });

  factory PtoAccion.fromMap(Map<String, dynamic> json) => PtoAccion(
      piAccionId: json["piAccionId"] as int? ?? 0,
      codAccion: json["codAccion"] as String? ?? '',
      descPiAccion: json["desPIAccion"] as String? ?? '');

  Map<String, dynamic> toMap() => {
        "piAccionId": piAccionId,
        "codAccion": codAccion,
        "desPIAccion": descPiAccion
      };

  PtoAccion.empty() {
    piAccionId = 0;
    codAccion = '';
    descPiAccion = '';
  }
}