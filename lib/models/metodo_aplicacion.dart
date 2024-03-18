import 'package:hive/hive.dart';
part 'metodo_aplicacion.g.dart';


@HiveType(typeId: 30)
class MetodoAplicacion extends HiveObject {
  @HiveField(0)
  late int metodoAplicacionId;
  @HiveField(1)
  late String codMetodoAplicacion;
  @HiveField(2)
  late String descripcion;
  
  MetodoAplicacion({
    required this.metodoAplicacionId,
    required this.codMetodoAplicacion,
    required this.descripcion,
  });

  factory MetodoAplicacion.fromJson(Map<String, dynamic> json) =>
      MetodoAplicacion(
        metodoAplicacionId: json["metodoAplicacionId"] as int? ?? 0,
        codMetodoAplicacion: json["codMetodoAplicacion"] as String? ?? '',
        descripcion: json["descripcion"] as String? ?? '',
      );

  Map<String, dynamic> toMap() => {
        "metodoAplicacionId": metodoAplicacionId,
        "codMetodoAplicacion": codMetodoAplicacion,
        "descripcion": descripcion,
      };

  MetodoAplicacion.empty() {
    metodoAplicacionId = 0;
    codMetodoAplicacion = '';
    descripcion = '';
  }

  @override
  String toString() {
    return descripcion;
  }
}