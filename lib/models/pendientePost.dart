
import 'package:app_tecnicos_sedel_wifiless/models/clientes_firmas.dart';
import 'package:app_tecnicos_sedel_wifiless/models/observacion.dart';
import 'package:app_tecnicos_sedel_wifiless/models/revision_materiales.dart';
import 'package:app_tecnicos_sedel_wifiless/models/revision_plaga.dart';
import 'package:app_tecnicos_sedel_wifiless/models/revision_tarea.dart';
import 'package:hive/hive.dart';

part 'pendientePost.g.dart';

@HiveType(typeId: 39)
class PendientePost extends HiveObject {
  @HiveField(0)
  late List<RevisionMaterial> materiales;
  @HiveField(1)
  late List<RevisionTarea> tareas;
  @HiveField(2)
  late List<RevisionPlaga> plagas;
  @HiveField(3)
  late List<Observacion> obsevacion;
  @HiveField(4)
  late List<ClienteFirma> firma;
  

 

  PendientePost ({
    required this.materiales,
    required this.tareas,
    required this.plagas,
    required this.obsevacion,
    required this.firma,
  });

  PendientePost.empty(){
    materiales = [];
    tareas = [];
    plagas = [];
    obsevacion = [];
    firma = [];
  }

}