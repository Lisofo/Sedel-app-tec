import 'package:hive_flutter/adapters.dart';

part 'tipo_orden.g.dart';

@HiveType(typeId: 1)
class TipoOrden extends HiveObject{
  @HiveField(0)
  late int tipoOrdenId;
  @HiveField(1)
  late String codTipoOrden;
  @HiveField(2)
  late String descripcion;

  TipoOrden({
    required this.tipoOrdenId,
    required this.codTipoOrden,
    required this.descripcion,
  });

  factory TipoOrden.fromMap(Map<String, dynamic> json) => TipoOrden(
    tipoOrdenId: json["tipoOrdenId"],
    codTipoOrden: json["codTipoOrden"],
    descripcion: json["descripcion"],
  );

  Map<String, dynamic> toMap() => {
        "tipoOrdenId": tipoOrdenId,
        "codTipoOrden": codTipoOrden,
        "descripcion": descripcion,
      };

  TipoOrden.empty() {
    tipoOrdenId = 0;
    codTipoOrden = '';
    descripcion = '';
  }
}