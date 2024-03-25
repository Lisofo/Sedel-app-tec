// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:app_tecnicos_sedel_wifiless/config/config.dart';
import 'package:app_tecnicos_sedel_wifiless/providers/orden_provider.dart';

class LoginServices {
  int? statusCode;
  String apiUrl = Config.APIURL;
  late String apiLink = '${apiUrl}api/auth/login-pin';

  Future<void> login(String login, pin2, BuildContext context) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({"login": login, "pin2": pin2});
    var dio = Dio();
    String link = apiLink;
    try {
      var resp = await dio.request(
        link,
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      statusCode = resp.statusCode;

      if (statusCode == 200) {
        print(resp.data['token']);
        Provider.of<OrdenProvider>(context, listen: false).setToken(resp.data['token']);
        Provider.of<OrdenProvider>(context, listen: false).setUsuarioId(resp.data['uid']);
        Provider.of<OrdenProvider>(context, listen: false).setNombreUsuario(resp.data['name']);
        Provider.of<OrdenProvider>(context, listen: false).setTecnicoId(resp.data['tecnicoId']);
      } else {
        print(resp.statusMessage);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<int?> getStatusCode() async {
    return statusCode;
  }
}
