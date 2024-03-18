import 'package:hive/hive.dart';

part 'cargo.g.dart';

@HiveType(typeId: 6)
class Cargo extends HiveObject{
  @HiveField(0)
  late int cargoId;
  @HiveField(1)
  late String codCargo;
  @HiveField(2)
  late String descripcion;

  Cargo({
    required this.cargoId,
    required this.codCargo,
    required this.descripcion,
  });

  factory Cargo.fromJson(Map<String, dynamic> json) => Cargo(
        cargoId: json["cargoId"],
        codCargo: json["codCargo"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toMap() => {
        "cargoId": cargoId,
        "codCargo": codCargo,
        "descripcion": descripcion,
      };
  Cargo.empty() {
    cargoId = 0;
    codCargo = '';
    descripcion = '';
  }

  @override
  String toString() {
    return cargoId.toString();
  }
}
