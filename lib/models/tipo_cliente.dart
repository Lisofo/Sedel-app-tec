import 'package:hive/hive.dart';
part 'tipo_cliente.g.dart';

@HiveType(typeId: 26)
class TipoCliente extends HiveObject{
  @HiveField(0)
  late int tipoClienteId;
  @HiveField(1)
  late String codTipoCliente;
  @HiveField(2)
  late String descripcion;

  TipoCliente({
    required this.tipoClienteId,
    required this.codTipoCliente,
    required this.descripcion,
  });

  factory TipoCliente.fromJson(Map<String, dynamic> json) => TipoCliente(
        tipoClienteId: json["tipoClienteId"],
        codTipoCliente: json["codTipoCliente"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toMap() => {
        "tipoClienteId": tipoClienteId,
        "codTipoCliente": codTipoCliente,
        "descripcion": descripcion,
      };
  TipoCliente.empty() {
    tipoClienteId = 0;
    codTipoCliente = '';
    descripcion = '';
  }
}
