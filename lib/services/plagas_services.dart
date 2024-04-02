// ignore_for_file: avoid_print

import 'package:app_tecnicos_sedel_wifiless/config/config.dart';
import 'package:app_tecnicos_sedel_wifiless/models/plaga.dart';
import 'package:app_tecnicos_sedel_wifiless/models/plaga_xtpi.dart';
import 'package:app_tecnicos_sedel_wifiless/models/plaga_objetivo.dart';
import 'package:app_tecnicos_sedel_wifiless/models/tipos_ptos_inspeccion.dart';
import 'package:app_tecnicos_sedel_wifiless/offline/boxes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PlagaServices {
  final _dio = Dio();
  String apiUrl = Config.APIURL;
  late String apiLink = '${apiUrl}api/v1/plagas/';

  Future getPlagas(String token) async {
    String link = apiLink;

    try {
      var headers = {'Authorization': token};
      var resp = await _dio.request(
        link,
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );
      final List<dynamic> plagaList = resp.data;

      return plagaList.map((obj) => Plaga.fromJson(obj)).toList();
    } catch (e) {
      print(e);
    }
  }

  Future<List<Plaga>> getPlagasOffline() async {
    List<Plaga> listaPlagasOffline = [];
    listaPlagasOffline = codigueras.values.whereType<Plaga>().toList();
    return listaPlagasOffline;
  }

  Future getPlagasXTPI(TipoPtosInspeccion tPI, String token) async {
    String link =
        '${apiUrl}api/v1/tipos/puntos/${tPI.tipoPuntoInspeccionId}/plagas';

    try {
      var headers = {'Authorization': token};
      var resp = await _dio.request(
        link,
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );
      final List<dynamic> plagaXTPIList = resp.data;

      return plagaXTPIList.map((obj) => PlagaXtpi.fromJson(obj)).toList();
    } catch (e) {
      print(e);
    }
  }

  Future getPlagasObjetivo(BuildContext context, String token) async {
    String link = '${apiUrl}api/v1/plagas-objetivo/';

    try {
      var headers = {'Authorization': token};
      var resp = await _dio.request(
        link,
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );
      final List<dynamic> plagaObjetivoList = resp.data;

      return plagaObjetivoList
          .map((obj) => PlagaObjetivo.fromJson(obj))
          .toList();
    } catch (e) {
      print(e);
    }
  }

  Future getPlagasObjetivoOffline() async {
    List<PlagaObjetivo> listaPlagasObjetivoOffline = [];
    listaPlagasObjetivoOffline = codigueras.values.whereType<PlagaObjetivo>().toList();
    return listaPlagasObjetivoOffline;
  }
}
