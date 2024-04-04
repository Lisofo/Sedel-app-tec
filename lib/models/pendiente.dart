import 'package:app_tecnicos_sedel_wifiless/models/pendienteDelete.dart';
import 'package:app_tecnicos_sedel_wifiless/models/pendientePost.dart';
import 'package:app_tecnicos_sedel_wifiless/models/pendientePut.dart';
import 'package:hive/hive.dart';

part 'pendiente.g.dart';

@HiveType(typeId: 40)
class Pendiente {
  @HiveField(0)
  late List<PendienteDelete> pendienteDelete;
  @HiveField(1)
  late List<PendientePost> pendientePost;
  @HiveField(2)
  late List<PendientePut> pendientePut;

  Pendiente ({
    required this.pendienteDelete,
    required this.pendientePost,
    required this.pendientePut,
  });



}