
import 'package:hive/hive.dart';

part 'pendienteDelete.g.dart';

@HiveType(typeId: 37)
class PendienteDelete extends HiveObject{
  
  @HiveField(0)
  late List<int> materiales;
  @HiveField(1)
  late List<int> tareas;
  @HiveField(2)
  late List<int> plagas;
  @HiveField(3)
  late List<int> obsevacion;
  @HiveField(4)
  late List<int> firma;
  

 

  PendienteDelete ({
    required this.materiales,
    required this.tareas,
    required this.plagas,
    required this.obsevacion,
    required this.firma,
  });

  PendienteDelete.empty(){
    materiales = [];
    tareas = [];
    plagas = [];
    obsevacion = [];
    firma = [];
  }

}