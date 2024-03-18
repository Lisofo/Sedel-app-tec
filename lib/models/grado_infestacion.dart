import 'package:hive/hive.dart';
part 'grado_infestacion.g.dart';

@HiveType(typeId: 11)
class GradoInfestacion extends HiveObject{
  @HiveField(0)
  late int gradoInfestacionId;
  @HiveField(1)
  late String codGradoInfestacion;
  @HiveField(2)
  late String descripcion;

  GradoInfestacion({
    required this.gradoInfestacionId,
    required this.codGradoInfestacion,
    required this.descripcion,
  });

  GradoInfestacion.empty() {
    gradoInfestacionId = 0;
    codGradoInfestacion = '';
    descripcion = '';
  }

  @override
  String toString() {
    return descripcion;
  }
}
