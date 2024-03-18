import 'package:hive/hive.dart';

part 'lote.g.dart';

@HiveType(typeId: 29)
class Lote extends HiveObject {
  @HiveField(0)
  late int materialLoteId;
  @HiveField(1)
  late String lote;

  Lote({
    required this.materialLoteId,
    required this.lote,
  });

  factory Lote.fromJson(Map<String, dynamic> json) => Lote(
        materialLoteId: json["materialLoteId"] as int? ?? 0,
        lote: json["lote"] as String? ?? '',
      );

  Map<String, dynamic> toMap() => {
        "materialLoteId": materialLoteId,
        "lote": lote,
      };

  Lote.empty() {
    materialLoteId = 0;
    lote = '';
  }

  @override
  String toString() {
    return lote;
  }
}