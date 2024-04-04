import 'package:app_tecnicos_sedel_wifiless/models/clientes_firmas.dart';
import 'package:app_tecnicos_sedel_wifiless/models/observacion.dart';
import 'package:app_tecnicos_sedel_wifiless/models/revision_materiales.dart';
import 'package:app_tecnicos_sedel_wifiless/models/revision_plaga.dart';
import 'package:app_tecnicos_sedel_wifiless/models/revision_pto_inspeccion.dart';
import 'package:app_tecnicos_sedel_wifiless/models/revision_tarea.dart';
import 'package:hive/hive.dart';
part 'revision.g.dart';

@HiveType(typeId: 31)
class Revision extends HiveObject {
  @HiveField(0)
  late int otRevisionId;
  @HiveField(1)
  late int otOrdenId;
  @HiveField(2)
  late List<RevisionPlaga> revisionPlaga;
  @HiveField(3)
  late List<RevisionMaterial> revisionMaterial;
  @HiveField(4)
  late List<ClienteFirma> revisionFirma;
  @HiveField(5)
  late List<RevisionPtoInspeccion> revisionPtoInspeccion;
  @HiveField(6)
  late List<RevisionTarea> revisionTarea;
  @HiveField(7)
  late List<Observacion> revisionObservacion;

  Revision({
    required this.otRevisionId,
    required this.otOrdenId,
    required this.revisionPlaga,
    required this.revisionMaterial,
    required this.revisionFirma,
    required this.revisionPtoInspeccion,
    required this.revisionTarea,
    required this.revisionObservacion,
  });

  Revision.empty(){
    otRevisionId = 0;
    otOrdenId = 0;
    revisionPlaga = [];
    revisionMaterial = [];
    revisionFirma = [];
    revisionPtoInspeccion = [];
    revisionTarea = [];
    revisionObservacion = [];
  }
}