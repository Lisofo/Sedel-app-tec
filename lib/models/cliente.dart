// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'departamento.dart';
import 'tecnico.dart';

import 'package:hive/hive.dart';

import 'tipo_cliente.dart';

part 'cliente.g.dart';

List<Cliente> clienteFromMap(String str) => List<Cliente>.from(json.decode(str).map((x) => Cliente.fromJson(x)));
String clienteToMap(List<Cliente> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

@HiveType(typeId: 2)
class Cliente extends HiveObject {
  @HiveField(0)
  late int clienteId;
  @HiveField(1)
  late String codCliente;
  @HiveField(2)
  late String nombre;
  @HiveField(3)
  late String nombreFantasia;
  @HiveField(4)
  late String direccion;
  @HiveField(5)
  late String barrio;
  @HiveField(6)
  late String localidad;
  @HiveField(7)
  late String telefono1;
  @HiveField(8)
  late String telefono2;
  @HiveField(9)
  late String email;
  @HiveField(10)
  late String ruc;
  @HiveField(11)
  late String estado;
  @HiveField(12)
  late dynamic coordenadas;
  @HiveField(13)
  late Tecnico tecnico;
  @HiveField(14)
  late Departamento departamento;
  @HiveField(15)
  late TipoCliente tipoCliente;
  @HiveField(16)
  var departamentoId;
  @HiveField(17)
  var tipoClienteId;
  @HiveField(18)
  var tecnicoId;
  @HiveField(19)
  late String notas;

  Cliente({
    required this.clienteId,
    required this.codCliente,
    required this.nombre,
    required this.nombreFantasia,
    required this.direccion,
    required this.barrio,
    required this.localidad,
    required this.telefono1,
    required this.telefono2,
    required this.email,
    required this.ruc,
    required this.estado,
    required this.coordenadas,
    required this.tecnico,
    required this.departamento,
    required this.tipoCliente,
    required this.notas,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        clienteId: json["clienteId"] as int? ?? 0,
        codCliente: json["codCliente"] as String? ?? '',
        nombre: json["nombre"] as String? ?? '',
        nombreFantasia: json["nombreFantasia"] as String? ?? '',
        direccion: json["direccion"] as String? ?? '',
        barrio: json["barrio"] as String? ?? '',
        localidad: json["localidad"] as String? ?? '',
        telefono1: json["telefono1"] as String? ?? '',
        telefono2: json["telefono2"] as String? ?? '',
        email: json["email"] as String? ?? '',
        ruc: json["ruc"] as String? ?? '',
        estado: json["estado"] as String? ?? '',
        coordenadas: json["coordenadas"] as String? ?? '',
        notas: json["notas"] as String? ?? '',
        tecnico: json["tecnico"] != null
            ? Tecnico.fromJson(json["tecnico"])
            : Tecnico.empty(),
        departamento: json["departamento"] != null
            ? Departamento.fromJson(json["departamento"])
            : Departamento.empty(),
        tipoCliente: json["tipoCliente"] != null
            ? TipoCliente.fromJson(json["tipoCliente"])
            : TipoCliente.empty(),
      );

  Map<String, dynamic> toMap() => {
        "clienteId": clienteId,
        "codCliente": codCliente,
        "nombre": nombre,
        "nombreFantasia": nombreFantasia,
        "direccion": direccion,
        "barrio": barrio,
        "localidad": localidad,
        "telefono1": telefono1,
        "telefono2": telefono2,
        "email": email,
        "ruc": ruc,
        "estado": estado,
        "coordenadas": coordenadas,
        "tecnico": tecnico.toMap(),
        "departamento": departamento.toMap(),
        "tipoCliente": tipoCliente.toMap(),
        "tecnicoId": tecnicoId,
        "departamentoId": departamentoId,
        "tipoClienteId": tipoClienteId,
        "notas": notas,
      };

  Cliente.empty() {
    clienteId = 0;
    codCliente = '';
    nombre = '';
    nombreFantasia = '';
    direccion = '';
    barrio = '';
    localidad = '';
    telefono1 = '';
    telefono2 = '';
    email = '';
    ruc = '';
    estado = '';
    coordenadas = '';
    tecnico = Tecnico.empty();
    departamento = Departamento.empty();
    tipoCliente = TipoCliente.empty();
    tecnicoId = 0;
    departamentoId = 0;
    tipoClienteId = 0;
    notas = '';
  }
}