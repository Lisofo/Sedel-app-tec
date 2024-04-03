import 'package:hive/hive.dart';

part 'lote.g.dart';

@HiveType(typeId: 29)
class Lote extends HiveObject {
  @HiveField(0)
  late int materialLoteId;
  @HiveField(1)
  late String lote;
  @HiveField(2)
  late String estado;


  Lote({
    required this.materialLoteId,
    required this.lote,
    required this.estado
  });

  factory Lote.fromJson(Map<String, dynamic> json) => Lote(
        materialLoteId: json["materialLoteId"] as int? ?? 0,
        lote: json["lote"] as String? ?? '',
        estado: json["estado"] as String? ?? '',
      );

  Map<String, dynamic> toMap() => {
        "materialLoteId": materialLoteId,
        "lote": lote,
        "estado": estado,
      };

  Lote.empty() {
    materialLoteId = 0;
    lote = '';
    estado = '';
  }

  @override
  String toString() {
    return lote;
  }
}