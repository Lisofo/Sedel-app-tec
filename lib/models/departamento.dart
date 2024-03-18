import 'package:hive/hive.dart';
part 'departamento.g.dart';

@HiveType(typeId: 10)
class Departamento extends HiveObject{
  @HiveField(0)
  late int? departamentoId;
  @HiveField(1)
  late String codDepartamento;
  @HiveField(2)
  late String nombre;
  @HiveField(3)
  late int zonaId;

  Departamento({
    required this.departamentoId,
    required this.codDepartamento,
    required this.nombre,
    required this.zonaId
  });

  factory Departamento.fromJson(Map<String, dynamic> json) => Departamento(
      departamentoId: json["departamentoId"] as int? ?? 0,
      codDepartamento: json["codDepartamento"] as String? ?? '',
      nombre: json["descripcion"] as String? ?? '',
      zonaId: json["zonaId"] as int? ?? 0);

  Map<String, dynamic> toMap() => {
        "departamentoId": departamentoId,
        "codDepartamento": codDepartamento,
        "descripcion": nombre,
        "zonaId": zonaId,
      };
  Departamento.empty() {
    departamentoId = 0;
    codDepartamento = '';
    nombre = '';
    zonaId = 0;
  }
}