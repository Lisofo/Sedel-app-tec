// ignore_for_file: prefer_null_aware_operators, depend_on_referenced_packages

import 'dart:convert';
import 'package:hive/hive.dart';

import 'cargo.dart';

part 'tecnico.g.dart';

List<Tecnico> tecnicoFromMap(String str) => List<Tecnico>.from(json.decode(str).map((x) => Tecnico.fromJson(x)));
String tecnicoToMap(List<Tecnico> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

@HiveType(typeId: 3)
class Tecnico {
  @HiveField(0)
  late int tecnicoId;
  @HiveField(1)
  late String codTecnico;
  @HiveField(2)
  late String nombre;
  @HiveField(3)
  late DateTime? fechaNacimiento;
  @HiveField(4)
  late String documento;
  @HiveField(5)
  late DateTime? fechaIngreso;
  @HiveField(6)
  late DateTime? fechaVtoCarneSalud;
  @HiveField(7)
  late bool? deshabilitado;
  @HiveField(8)
  late Cargo? cargo;

  Tecnico({
    required this.tecnicoId,
    required this.codTecnico,
    required this.nombre,
    required this.fechaNacimiento,
    required this.documento,
    required this.fechaIngreso,
    required this.fechaVtoCarneSalud,
    required this.deshabilitado,
    required this.cargo,
  });

  factory Tecnico.fromJson(Map<String, dynamic> json) => Tecnico(
        tecnicoId: json["tecnicoId"] as int? ?? 0,
        codTecnico: json["codTecnico"] as String? ?? '',
        nombre: json["nombre"] as String? ?? '',
        fechaNacimiento: (json["fechaNacimiento"] == null ||
                json["fechaNacimiento"] == 'null')
            ? null
            : DateTime.tryParse(json["fechaNacimiento"]),
        documento: json["documento"] as String? ?? '',
        fechaIngreso:
            (json["fechaIngreso"] == null || json["fechaIngreso"] == 'null')
                ? null
                : DateTime.tryParse(json["fechaIngreso"]),
        fechaVtoCarneSalud: (json["fechaVtoCarneSalud"] == null ||
                json["fechaVtoCarneSalud"] == 'null')
            ? null
            : DateTime.tryParse(json["fechaVtoCarneSalud"]),
        deshabilitado: json["deshabilitado"] as bool? ?? false,
        cargo: json["cargo"] != null ? Cargo.fromJson(json["cargo"]) : null,
      );

  Map<String, dynamic> toMap() => {
        "tecnicoId": tecnicoId,
        "codTecnico": codTecnico,
        "nombre": nombre,
        "fechaNacimiento":
            fechaNacimiento == null ? null : fechaNacimiento!.toIso8601String(),
        "documento": documento,
        "fechaIngreso":
            fechaIngreso == null ? null : fechaIngreso!.toIso8601String(),
        "fechaVtoCarneSalud": fechaVtoCarneSalud == null
            ? null
            : fechaVtoCarneSalud!.toIso8601String(),
        "deshabilitado": deshabilitado,
        "cargo": null //cargo == null ? Cargo.empty() : cargo!.toMap(),
      };

  Tecnico.empty() {
    tecnicoId = 0;
    codTecnico = '';
    nombre = '';
    fechaNacimiento = DateTime.now();
    documento = '';
    fechaIngreso = DateTime.now();
    fechaVtoCarneSalud = DateTime.now();
    deshabilitado = false;
    cargo = Cargo(cargoId: 0, codCargo: '', descripcion: '');
  }
}