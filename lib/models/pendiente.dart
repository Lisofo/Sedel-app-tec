
import 'package:hive/hive.dart';

part 'pendiente.g.dart';

@HiveType(typeId: 37)

class Pendiente extends HiveObject {

  @HiveField(0)
  late int? ordenId;
  @HiveField(1)
  late int? otRevisionId;
  @HiveField(2)
  late dynamic objeto;
  @HiveField(3)
  late int accion;
  @HiveField(4)
  late int tipo;

  Pendiente ({
    required this.ordenId,
    required this.otRevisionId,
    required this.objeto,
    required this.accion,
    required this.tipo,
  });

  Pendiente.empty(){
    ordenId = 0;
    otRevisionId = 0;
    objeto = null;
    accion = 0;
    tipo = 0;
  }

}