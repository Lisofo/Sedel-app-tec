import 'dart:convert';
import 'package:hive/hive.dart';
part 'ubicacion.g.dart';

List<Ubicacion> ubicacionFromMap(String str) => List<Ubicacion>.from(json.decode(str).map((x) => Ubicacion.fromJson(x)));
String ubicacionToMap(List<Ubicacion> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

@HiveType(typeId: 28)
class Ubicacion extends HiveObject{
  @HiveField(0)
  late int ubicacionId;
  @HiveField(1)
  late DateTime fecha;
  @HiveField(2)
  late String ubicacion;
  @HiveField(3)
  late int usuarioId;
  @HiveField(4)
  late String login;
  @HiveField(5)
  late String nombre;
  @HiveField(6)
  late String? apellido;

  Ubicacion({
    required this.ubicacionId,
    required this.fecha,
    required this.ubicacion,
    required this.usuarioId,
    required this.login,
    required this.nombre,
    required this.apellido,
  });

  factory Ubicacion.fromJson(Map<String, dynamic> json) => Ubicacion(
        ubicacionId: json["ubicacionId"],
        fecha: DateTime.parse(json["fecha"]),
        ubicacion: json["ubicacion"],
        usuarioId: json["usuarioId"],
        login: json["login"],
        nombre: json["nombre"],
        apellido: json["apellido"],
      );

  Map<String, dynamic> toMap() => {
        "ubicacionId": ubicacionId,
        "fecha": _formatDateAndTime(fecha),
        "ubicacion": ubicacion,
        "usuarioId": usuarioId,
        "login": login,
        "nombre": nombre,
        "apellido": apellido,
      };

  Ubicacion.empty() {
    ubicacionId = 0;
    fecha = DateTime.now();
    ubicacion = '';
    usuarioId = 0;
    login = '';
    nombre = '';
    apellido = '';
  }

  String _formatDateAndTime(DateTime date) {
    return '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}T${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}:${date.second.toString().padLeft(2, '0')}';
  }
}
