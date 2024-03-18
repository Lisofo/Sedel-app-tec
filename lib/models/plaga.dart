import 'dart:convert';
import 'package:hive/hive.dart';
part 'plaga.g.dart';

List<Plaga> plagaFromMap(String str) => List<Plaga>.from(json.decode(str).map((x) => Plaga.fromJson(x)));
String plagaToMap(List<Plaga> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

@HiveType(typeId: 16)
class Plaga extends HiveObject{
  @HiveField(0)
  late int plagaId;
  @HiveField(1)
  late String codPlaga;
  @HiveField(2)
  late String descripcion;

  Plaga({
    required this.plagaId,
    required this.codPlaga,
    required this.descripcion,
  });

  factory Plaga.fromJson(Map<String, dynamic> json) => Plaga(
        plagaId: json["plagaId"],
        codPlaga: json["codPlaga"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toMap() => {
        "plagaId": plagaId,
        "codPlaga": codPlaga,
        "descripcion": descripcion,
      };

  Plaga.empty() {
    plagaId = 0;
    codPlaga = '';
    descripcion = '';
  }

  @override
  String toString() {
    return descripcion;
  }
}
