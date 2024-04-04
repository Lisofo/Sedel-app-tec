
import 'package:hive/hive.dart';

part 'pendienteDelete.g.dart';

@HiveType(typeId: 37)
class PendienteDelete extends HiveObject{
  @HiveField(0)
  late int ordenId;
  @HiveField(1)
  late int otRevisionId;
  @HiveField(2)
  late List<int> materiales;
  @HiveField(3)
  late List<int> tareas;
  @HiveField(4)
  late List<int> plagas;
  @HiveField(5)
  late List<int> obsevacion;
  @HiveField(6)
  late List<int> firma;
  

 

  PendienteDelete ({
    required this.ordenId,
    required this.otRevisionId,
    required this.materiales,
    required this.tareas,
    required this.plagas,
    required this.obsevacion,
    required this.firma,
  });

  PendienteDelete.empty(){
    ordenId = 0;
    otRevisionId = 0;
    materiales = [];
    tareas = [];
    plagas = [];
    obsevacion = [];
    firma = [];
  }

}