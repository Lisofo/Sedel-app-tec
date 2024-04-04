import 'package:app_tecnicos_sedel_wifiless/models/pendienteDelete.dart';
import 'package:app_tecnicos_sedel_wifiless/models/pendientePost.dart';
import 'package:app_tecnicos_sedel_wifiless/models/pendientePut.dart';
import 'package:hive/hive.dart';

part 'pendiente.g.dart';

@HiveType(typeId: 40)

class Pendiente extends HiveObject {

  @HiveField(0)
  late List<PendienteDelete> pendienteDelete;
  @HiveField(1)
  late List<PendientePost> pendientePost;
  @HiveField(2)
  late List<PendientePut> pendientePut;
  @HiveField(3)
  late int ordenId;
  @HiveField(4)
  late int otRevisionId;

  Pendiente ({
    required this.pendienteDelete,
    required this.pendientePost,
    required this.pendientePut,
    required this.ordenId,
    required this.otRevisionId,
  });

  Pendiente.empty(){
    pendienteDelete = [];
    pendientePost = [];
    pendientePut = [];
    ordenId = 0;
    otRevisionId = 0;
  }

}