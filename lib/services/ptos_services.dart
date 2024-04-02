// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:app_tecnicos_sedel_wifiless/config/config.dart';
import 'package:app_tecnicos_sedel_wifiless/models/orden.dart';
import 'package:app_tecnicos_sedel_wifiless/models/revision_pto_inspeccion.dart';
import 'package:app_tecnicos_sedel_wifiless/models/tipos_ptos_inspeccion.dart';
import 'package:app_tecnicos_sedel_wifiless/providers/orden_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../offline/boxes.dart';

class PtosInspeccionServices {
  final _dio = Dio();
  String apiUrl = Config.APIURL;

  static Future<void> showDialogs(
    BuildContext context,
    String errorMessage,
    bool doblePop,
    bool triplePop,
  ) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Mensaje'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (doblePop) {
                  Navigator.of(context).pop();
                }
                if (triplePop) {
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> mostrarError(BuildContext context, String mensaje) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Error'),
        content: Text(mensaje),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  Future getTiposPtosInspeccion(String token) async {
    String link = '${apiUrl}api/v1/tipos/puntos';

    try {
      var headers = {'Authorization': token};
      var resp = await _dio.request(
        link,
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );
      final List tipoPtoInspeccionList = resp.data;
      var retorno = tipoPtoInspeccionList
          .map((e) => TipoPtosInspeccion.fromJson(e))
          .toList();

      return retorno;
    } catch (e) {
      print(e);
    }
  }

  Future getTiposPtosInspeccionOffline() async {
    List<TipoPtosInspeccion> listaTipoPtosInspeccion = [];
    listaTipoPtosInspeccion = codigueras.values.whereType<TipoPtosInspeccion>().toList();
    return listaTipoPtosInspeccion;
  }

  Future getPtosInspeccion(BuildContext context, Orden orden, String token) async {
    String link = '${apiUrl}api/v1/ordenes/${orden.ordenTrabajoId}/revisiones/${orden.otRevisionId}/puntos/acciones/';

    try {
      var headers = {'Authorization': token};
      var resp = await _dio.request(
        link,
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );
      final List ptoInspeccionList = resp.data;
      var retorno = ptoInspeccionList.map((e) => RevisionPtoInspeccion.fromJson(e)).toList();

      Provider.of<OrdenProvider>(context, listen: false).setPI(retorno);

      return retorno;
    } catch (e) {
      print(e);
    }
  }

  Future postPtoInspeccionAccion(BuildContext context, Orden orden, RevisionPtoInspeccion revisionPtoInspeccion, String token) async {
    String link = '${apiUrl}api/v1/ordenes/${orden.ordenTrabajoId}/revisiones/${orden.otRevisionId}/puntos/${revisionPtoInspeccion.puntoInspeccionId}/acciones';
    print(link);

    var data;
    switch (revisionPtoInspeccion.idPIAccion) {
      case 1:
        data = ({"idPIAccion": 1, "comentario": revisionPtoInspeccion.comentario});
        break;
      case 4:
        data = ({"idPIAccion": 4, "comentario": revisionPtoInspeccion.comentario});
        break;
      case 7:
        data = ({"idPIAccion": 7, "comentario": revisionPtoInspeccion.comentario});
        break;
      case 2:
        data = ({
          "idPIAccion": 2,
          "comentario": "actividad",
          "materiales": revisionPtoInspeccion.materiales
              .map((material) => material.toMap())
              .toList(),
          "tareas": revisionPtoInspeccion.tareas
              .map((tarea) => tarea.toMap())
              .toList(),
          "plagas": revisionPtoInspeccion.plagas
              .map((plaga) => plaga.toMap())
              .toList()
        });
        break;
      case 3:
        data = ({
          "idPIAccion": 3,
          "comentario": "mantenimiento",
          "materiales": revisionPtoInspeccion.materiales
              .map((material) => material.toMap())
              .toList(),
          "tareas": revisionPtoInspeccion.tareas
              .map((tarea) => tarea.toMap())
              .toList(),
        });
      case 6:
        data = ({
          "idPIAccion": 6,
          "comentario": revisionPtoInspeccion.comentario,
          "zona": revisionPtoInspeccion.zona,
          "sector": revisionPtoInspeccion.sector
        });
        break;
      case 5:
        data = ({
          "idPIAccion": 5,
          "comentario": revisionPtoInspeccion.comentario,
          "idTipoPuntoInspeccion": revisionPtoInspeccion.tipoPuntoInspeccionId,
          "idPlagaObjetivo": revisionPtoInspeccion.plagaObjetivoId,
          "codPuntoInspeccion": revisionPtoInspeccion.codPuntoInspeccion,
          "codigoBarra": revisionPtoInspeccion.codigoBarra,
          "zona": revisionPtoInspeccion.zona,
          "sector": revisionPtoInspeccion.sector
        });
        break;
    }
    print(data);
    try {
      var headers = {'Authorization': token};
      var resp = await _dio.request(link,
          options: Options(
            method: 'POST',
            headers: headers,
          ),
          data: data);
      if (resp.statusCode == 201) {
        revisionPtoInspeccion.otPuntoInspeccionId =
            resp.data["otPuntoInspeccionId"];
      }
      return;
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          final responseData = e.response!.data;
          if (responseData != null) {
            final errors = responseData['errors'] as List<dynamic>;
            final errorMessages = errors.map((error) {
              return "Error: ${error['message']}";
            }).toList();
            await mostrarError(context, errorMessages.join('\n'));
          } else {
            await mostrarError(context, 'Error: ${e.response!.data}');
          }
        } else {
          await mostrarError(context, 'Error: ${e.message}');
        }
      }
    }
  }

  Future putPtoInspeccionAccionOffline(Orden orden, RevisionPtoInspeccion nuevaRevisionPtoInspeccion) async {
    RevisionPtoInspeccion ptoAEditar;
    
    ptoAEditar = revisiones.values.where((revision) => revision.otRevisionId == orden.otRevisionId).where(
      (puntoInspeccion) => puntoInspeccion.puntoInspeccionId == nuevaRevisionPtoInspeccion.puntoInspeccionId).toList()[0];


  }

  Future putPtoInspeccionAccion(BuildContext context, Orden orden,
      RevisionPtoInspeccion revisionPtoInspeccion, String token) async {
    String link =
        '${apiUrl}api/v1/ordenes/${orden.ordenTrabajoId}/revisiones/${orden.otRevisionId}/puntos/${revisionPtoInspeccion.puntoInspeccionId}/acciones/${revisionPtoInspeccion.otPuntoInspeccionId}';
    print(link);

    var data;
    switch (revisionPtoInspeccion.idPIAccion) {
      case 1:
        data =
            ({"idPIAccion": 1, "comentario": revisionPtoInspeccion.comentario});
        break;
      case 4:
        data =
            ({"idPIAccion": 4, "comentario": revisionPtoInspeccion.comentario});
        break;
      case 7:
        data =
            ({"idPIAccion": 7, "comentario": revisionPtoInspeccion.comentario});
        break;
      case 2:
        data = ({
          "idPIAccion": 2,
          "comentario": "actividad",
          "materiales": revisionPtoInspeccion.materiales
              .map((material) => material.toMap())
              .toList(),
          "tareas": revisionPtoInspeccion.tareas
              .map((tarea) => tarea.toMap())
              .toList(),
          "plagas": revisionPtoInspeccion.plagas
              .map((plaga) => plaga.toMap())
              .toList()
        });
        break;
      case 3:
        data = ({
          "idPIAccion": 3,
          "comentario": "mantenimiento",
          "materiales": revisionPtoInspeccion.materiales
              .map((material) => material.toMap())
              .toList(),
          "tareas": revisionPtoInspeccion.tareas
              .map((tarea) => tarea.toMap())
              .toList(),
        });
      case 6:
        data = ({
          "idPIAccion": 6,
          "comentario": revisionPtoInspeccion.comentario,
          "zona": revisionPtoInspeccion.zona,
          "sector": revisionPtoInspeccion.sector
        });
        break;
      case 5:
        data = ({
          "idPIAccion": 5,
          "comentario": revisionPtoInspeccion.comentario,
          "idTipoPuntoInspeccion": revisionPtoInspeccion.tipoPuntoInspeccionId,
          "idPlagaObjetivo": revisionPtoInspeccion.plagaObjetivoId,
          "codPuntoInspeccion": revisionPtoInspeccion.codPuntoInspeccion,
          "codigoBarra": revisionPtoInspeccion.codigoBarra,
          "zona": revisionPtoInspeccion.zona,
          "sector": revisionPtoInspeccion.sector
        });
        break;
    }
    print(data);
    try {
      var headers = {'Authorization': token};
      var resp = await _dio.request(link,
          options: Options(
            method: 'PUT',
            headers: headers,
          ),
          data: data);
      if (resp.statusCode == 200) {
        revisionPtoInspeccion.otPuntoInspeccionId =
            resp.data["otPuntoInspeccionId"];
      }
      return;
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          final responseData = e.response!.data;
          if (responseData != null) {
            final errors = responseData['errors'] as List<dynamic>;
            final errorMessages = errors.map((error) {
              return "Error: ${error['message']}";
            }).toList();
            await mostrarError(context, errorMessages.join('\n'));
          } else {
            await mostrarError(context, 'Error: ${e.response!.data}');
          }
        } else {
          await mostrarError(context, 'Error: ${e.message}');
        }
      }
    }
  }

  Future deleteAccionesPI(BuildContext context, Orden orden,
      RevisionPtoInspeccion revisionPtoInspeccion, String token) async {
    String link =
        '${apiUrl}api/v1/ordenes/${orden.ordenTrabajoId}/revisiones/${orden.otRevisionId}/puntos/${revisionPtoInspeccion.puntoInspeccionId}/acciones/${revisionPtoInspeccion.otPuntoInspeccionId}';
    print(link);

    try {
      var headers = {'Authorization': token};
      var resp = await _dio.request(
        link,
        options: Options(
          method: 'DELETE',
          headers: headers,
        ),
      );

      return resp;
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          final responseData = e.response!.data;
          if (responseData != null) {
            final errors = responseData['errors'] as List<dynamic>;
            final errorMessages = errors.map((error) {
              return "Error: ${error['message']}";
            }).toList();
            await mostrarError(context, errorMessages.join('\n'));
          } else {
            await mostrarError(context, 'Error: ${e.response!.data}');
          }
        } else {
          await mostrarError(context, 'Error: ${e.message}');
        }
      }
    }
  }

  Future getPIActividad(BuildContext context, Orden orden,
      RevisionPtoInspeccion revisionPtoInspeccion, String token) async {
    String link =
        '${apiUrl}api/v1/ordenes/${orden.ordenTrabajoId}/revisiones/${orden.otRevisionId}/puntos/${revisionPtoInspeccion.puntoInspeccionId}/acciones/${revisionPtoInspeccion.otPuntoInspeccionId}';

    try {
      var headers = {'Authorization': token};
      var resp = await _dio.request(
        link,
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      final RevisionPtoInspeccion ptoInspeccion =
          RevisionPtoInspeccion.fromJson(resp.data);
      return ptoInspeccion;
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          final responseData = e.response!.data;
          if (responseData != null) {
            final errors = responseData['errors'] as List<dynamic>;
            final errorMessages = errors.map((error) {
              return "Error: ${error['message']}";
            }).toList();
            await mostrarError(context, errorMessages.join('\n'));
          } else {
            await mostrarError(context, 'Error: ${e.response!.data}');
          }
        } else {
          await mostrarError(context, 'Error: ${e.message}');
        }
      }
    }
  }
}
