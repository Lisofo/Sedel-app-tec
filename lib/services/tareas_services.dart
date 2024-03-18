// ignore_for_file: avoid_print

import 'package:app_tecnicos_sedel_wifiless/config/config.dart';
import 'package:app_tecnicos_sedel_wifiless/models/tarea.dart';
import 'package:app_tecnicos_sedel_wifiless/models/tarea_xtpi.dart';
import 'package:app_tecnicos_sedel_wifiless/models/tipos_ptos_inspeccion.dart';
import 'package:app_tecnicos_sedel_wifiless/offline/boxes.dart';
import 'package:dio/dio.dart';

class TareasServices {
  final _dio = Dio();
  String apiLink = Config.APIURL;

  Future getTareas(String token) async {
    String link = '${apiLink}api/v1/tareas/';

    try {
      var headers = {'Authorization': token};
      var resp = await _dio.request(
        link,
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );
      final List<dynamic> tareaList = resp.data;

      return tareaList.map((obj) => Tarea.fromJson(obj)).toList();
    } catch (e) {
      print(e);
    }
  }

  Future<List<Tarea>> getTareasOffline() async {
    List<Tarea> listaTareasOffline =[];
    listaTareasOffline = codigueras.values.whereType<Tarea>().toList();
    return listaTareasOffline;
  }
  
  Future getTareasXTPI(TipoPtosInspeccion tPI,String modo, String token) async {
    String link = '${apiLink}api/v1/tipos/puntos/${tPI.tipoPuntoInspeccionId}/tareas?modo=$modo';

    try {
      var headers = {'Authorization': token};
      var resp = await _dio.request(
        link,
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );
      final List<dynamic> tareaXPTIList = resp.data;

      return tareaXPTIList.map((obj) => TareaXtpi.fromJson(obj)).toList();
    } catch (e) {
      print(e);
    }
  }
}
