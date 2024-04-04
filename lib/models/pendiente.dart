
import 'package:hive/hive.dart';

part 'pendiente.g.dart';

@HiveType(typeId: 37)

class Pendiente extends HiveObject {

  @HiveField(0)
  late int? ordenId;
  @HiveField(1)
  late int? otRevisionId;
  @HiveField(2)
  late List<dynamic> listaPendientes;
  @HiveField(3)
  late int accion;

  Pendiente ({
    required this.ordenId,
    required this.otRevisionId,
    required this.listaPendientes,
    required this.accion,
  });

  Pendiente.empty(){
    ordenId = 0;
    otRevisionId = 0;
    listaPendientes = [];
    accion = 0;
  }

}