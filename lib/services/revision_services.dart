// ignore_for_file: unused_element, unused_local_variable, avoid_print, use_build_context_synchronously

import 'package:app_tecnicos_sedel_wifiless/config/config.dart';
import 'package:app_tecnicos_sedel_wifiless/config/router/router.dart';
import 'package:app_tecnicos_sedel_wifiless/models/clientes_firmas.dart';
import 'package:app_tecnicos_sedel_wifiless/models/observacion.dart';
import 'package:app_tecnicos_sedel_wifiless/models/orden.dart';
import 'package:app_tecnicos_sedel_wifiless/models/revision.dart';
import 'package:app_tecnicos_sedel_wifiless/models/revision_plaga.dart';
import 'package:app_tecnicos_sedel_wifiless/models/revision_tarea.dart';
import 'package:app_tecnicos_sedel_wifiless/offline/boxes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RevisionServices {
  final _dio = Dio();
  String apiLink = Config.APIURL;

  static Future<void> showDialogs(BuildContext context, String errorMessage,
      bool doblePop, bool triplePop) async {
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

  Future<void> _mostrarError(BuildContext context, String mensaje) async {
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

  Future postRevision(int uId, Orden orden, String token) async {
    String link = apiLink;
    link += 'api/v1/ordenes/${orden.ordenTrabajoId}/revisiones';
    var data = ({"idUsuario": uId, "ordinal": 0, "comentario": "Revision del Técnico"});
    try {
      var headers = {'Authorization': token};
      var resp = await _dio.request(link,
          options: Options(
            method: 'POST',
            headers: headers,
          ),
          data: data);
      if (resp.statusCode == 201) {
        orden.otRevisionId = resp.data["otRevisionId"];
        print(resp);
      }
      return;
    } catch (e) {
      print(e);
    }
  }

  Future postObservacion(
      BuildContext context, Orden orden, Observacion obs, String token) async {
    String link = apiLink;
    link += 'api/v1/ordenes/${orden.ordenTrabajoId}/revisiones/${orden.otRevisionId}/observaciones';
    var data = obs.toMap();
    try {
      var headers = {'Authorization': token};
      var resp = await _dio.request(link,
          options: Options(
            method: 'POST',
            headers: headers,
          ),
          data: data);
      if (resp.statusCode == 201) {
        obs.otObservacionId = resp.data["otObservacionId"];
        showDialogs(context, 'Observaciones guardadas', false, false);
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
            await _mostrarError(context, errorMessages.join('\n'));
          } else {
            await _mostrarError(context, 'Error: ${e.response!.data}');
          }
        } else {
          await _mostrarError(context, 'Error: ${e.message}');
        }
      }
    }
  }

  Future putObservacion(
      BuildContext context, Orden orden, Observacion obs, String token) async {
    String link = apiLink;
    link +=
        'api/v1/ordenes/${orden.ordenTrabajoId.toString()}/revisiones/${orden.otRevisionId.toString()}/observaciones/${obs.otObservacionId}';
    var data = obs.toMap();
    try {
      var headers = {'Authorization': token};
      var resp = await _dio.request(link,
          options: Options(
            method: 'PUT',
            headers: headers,
          ),
          data: data);
      if (resp.statusCode == 200) {
        showDialogs(context, 'Observaciones guardadas', false, false);
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
            await _mostrarError(context, errorMessages.join('\n'));
          } else {
            await _mostrarError(context, 'Error: ${e.response!.data}');
          }
        } else {
          await _mostrarError(context, 'Error: ${e.message}');
        }
      }
    }
  }

  Future getObservacion(Orden orden, String token) async {
    String link = apiLink;
    link += 'api/v1/ordenes/${orden.ordenTrabajoId}/revisiones/${orden.otRevisionId}/observaciones';

    try {
      var headers = {'Authorization': token};
      var resp = await _dio.request(
        link,
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );
      final List observacionList = resp.data;
      var retorno = observacionList.map((e) => Observacion.fromJson(e)).toList();

      return retorno;
    } catch (e) {
      print(e);
    }
  }
  
  Future<List<Observacion>> getObservacionOffline(Orden orden) async {
    List<Observacion> observacionOffline = [];
    observacionOffline = revisiones.values.whereType<Observacion>().where((revisionObservacion) => revisionObservacion.otRevisionId == orden.otRevisionId).toList();
    return observacionOffline;
  }

  Future getRevisionTareas(Orden orden, String token) async {
    String link = '${apiLink}api/v1/ordenes/${orden.ordenTrabajoId.toString()}/revisiones/${orden.otRevisionId}/tareas';

    try {
      var headers = {'Authorization': token};
      var resp = await _dio.request(
        link,
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );
      final List<dynamic> revisionTareaList = resp.data;

      return revisionTareaList
          .map((obj) => RevisionTarea.fromJson(obj))
          .toList();
    } catch (e) {
      print(e);
    }
  }

  Future postRevisionTarea(BuildContext context, Orden orden,  RevisionTarea revisionTarea, String token) async {
    String link = '${apiLink}api/v1/ordenes/${orden.ordenTrabajoId}/revisiones/${orden.otRevisionId}/tareas';
    var data = ({"idTarea": revisionTarea.tareaId, "comentario": ""});

    try {
      var headers = {'Authorization': token};
      var resp = await _dio.request(
        link,
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );
      if (resp.statusCode == 201) {
        revisionTarea.otTareaId = resp.data["otTareaId"];
        // showDialogs(context, 'Tarea guardada', false, false);
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
            await _mostrarError(context, errorMessages.join('\n'));
          } else {
            await _mostrarError(context, 'Error: ${e.response!.data}');
          }
        } else {
          await _mostrarError(context, 'Error: ${e.message}');
        }
      }
    }
  }

  Future deleteRevisionTarea(BuildContext context, Orden orden,
      RevisionTarea revisionTarea, String token) async {
    String link = '${apiLink}api/v1/ordenes/${orden.ordenTrabajoId.toString()}/revisiones/${orden.otRevisionId}/tareas/${revisionTarea.otTareaId}';
    try {
      var headers = {'Authorization': token};
      var resp = await _dio.request(
        link,
        options: Options(
          method: 'DELETE',
          headers: headers,
        ),
      );
      if (resp.statusCode == 204) {
        // showDialogs(context, 'Tarea borrada', true, false);
        router.pop(context);
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          final responseData = e.response!.data;
          if (responseData != null) {
            final errors = responseData['errors'] as List<dynamic>;
            final errorMessages = errors.map((error) {
              return "Error: ${error['message']}";
            }).toList();
            await _mostrarError(context, errorMessages.join('\n'));
          } else {
            await _mostrarError(context, 'Error: ${e.response!.data}');
          }
        } else {
          await _mostrarError(context, 'Error: ${e.message}');
        }
      }
    }
  }

  Future deleteRevisionTareaOffline(RevisionTarea revisionTarea, Orden orden) async {
    Revision revision = revisiones.values.where((revision) => revision.otRevisionId == orden.otRevisionId).toList()[0];
    revision.revisionTarea.removeWhere((tarea) => tarea.tareaId == revisionTarea.tareaId);
    print('Plaga eliminada con éxito');
  }

  Future getRevisionPlagas(Orden orden, String token) async {
    String link = '${apiLink}api/v1/ordenes/${orden.ordenTrabajoId}/revisiones/${orden.otRevisionId}/plagas';

    try {
      var headers = {'Authorization': token};
      var resp = await _dio.request(
        link,
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );
      final List<dynamic> revisionPlagasList = resp.data;

      return revisionPlagasList.map((obj) => RevisionPlaga.fromJson(obj)).toList();
    } catch (e) {
      print(e);
    }
  }

  // Future<List<RevisionPlaga>> getRevisionPlagasOffline(Orden orden) async {
  //   List<RevisionPlaga> listaRevisionPlagasOffline = [];

  //   listaRevisionPlagasOffline = revisiones.values.whereType<RevisionPlaga>().where((revisionPlaga) => revisionPlaga.otRevisionId == orden.otRevisionId).toList();
  //   print(listaRevisionPlagasOffline.length);
  //   return listaRevisionPlagasOffline;
  // }

  Future deleteRevisionPlaga(BuildContext context, Orden orden, RevisionPlaga revisionPlaga, String token) async {

    String link = '${apiLink}api/v1/ordenes/${orden.ordenTrabajoId}/revisiones/${orden.otRevisionId}/plagas/${revisionPlaga.otPlagaId}';
    try {
      var headers = {'Authorization': token};
      var resp = await _dio.request(
        link,
        options: Options(
          method: 'DELETE',
          headers: headers,
        ),
      );
      if (resp.statusCode == 204) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('La plaga ${revisionPlaga.plaga} ha sido borrada'),
        //   )
        // );
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          final responseData = e.response!.data;
          if (responseData != null) {
            final errors = responseData['errors'] as List<dynamic>;
            final errorMessages = errors.map((error) {
              return "Error: ${error['message']}";
            }).toList();
            await _mostrarError(context, errorMessages.join('\n'));
          } else {
            await _mostrarError(context, 'Error: ${e.response!.data}');
          }
        } else {
          await _mostrarError(context, 'Error: ${e.message}');
        }
      }
    }
  }
  
  Future deleteRevisionPlagaOffline(RevisionPlaga revisionPlaga, Orden orden) async {
    Revision revision = revisiones.values.where((revision) => revision.otRevisionId == orden.otRevisionId).toList()[0];
    revision.revisionPlaga.removeWhere((plaga) => plaga.plagaId == revisionPlaga.plagaId);
    print('Plaga eliminada con éxito');
 
  }

  Future postRevisionPlaga(BuildContext context, Orden orden, RevisionPlaga revisionPlaga, String token) async {
    String link = '${apiLink}api/v1/ordenes/${orden.ordenTrabajoId}/revisiones/${orden.otRevisionId}/plagas';
    var data = ({
      "idPlaga": revisionPlaga.plagaId,
      "idGradoInfestacion": revisionPlaga.gradoInfestacionId,
      "comentario": ""
    });

    try {
      var headers = {'Authorization': token};
      var resp = await _dio.request(
        link,
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );
      if (resp.statusCode == 201) {
        revisionPlaga.otPlagaId = resp.data["otPlagaId"];
        // showDialogs(context, 'Plaga guardada', false, false);
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
            await _mostrarError(context, errorMessages.join('\n'));
          } else {
            await _mostrarError(context, 'Error: ${e.response!.data}');
          }
        } else {
          await _mostrarError(context, 'Error: ${e.message}');
        }
      }
    }
  }

  Future<int?> getStatusCodeFirma() async {
    return statusCode;
  }
  int? statusCode;

  Future postRevisonFirma(BuildContext context, Orden orden, ClienteFirma firma, String token) async {
    String link = '${apiLink}api/v1/ordenes/${orden.ordenTrabajoId}/revisiones/${orden.otRevisionId}/firmas';

    FormData formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(firma.firma as List<int>, filename: 'imagen.jpg'),
      'nombre': firma.nombre,
      'area': firma.area,
      'firmaMD5': firma.firmaMd5,
      'comentario': ''
    });

    try {
      var headers = {'Authorization': token};
      var resp = await _dio.post(
        link,
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
          headers: headers,
        ),
      );
      statusCode = resp.statusCode;
      if (statusCode == 201) {
        firma.otFirmaId = resp.data["otFirmaId"];
        showDialogs(context, 'Firma guardada', false, false);
        print('posteo $statusCode');
      }
      print('termino posteo $statusCode');
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
            await _mostrarError(context, errorMessages.join('\n'));
          } else {
            await _mostrarError(context, 'Error: ${e.response!.data}');
          }
        } else {
          await _mostrarError(context, 'Error: ${e.message}');
        }
      }
    }
  }

  Future getRevisionFirmas(Orden orden, String token) async {
    String link = '${apiLink}api/v1/ordenes/${orden.ordenTrabajoId.toString()}/revisiones/${orden.otRevisionId}/firmas';

    try {
      var headers = {'Authorization': token};
      var resp = await _dio.request(
        link,
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );
      final List<dynamic> revisionFirmasList = resp.data;

      return revisionFirmasList
          .map((obj) => ClienteFirma.fromJson(obj))
          .toList();
    } catch (e) {
      print(e);
    }
  }

  Future deleteRevisionFirma(BuildContext context, Orden orden, ClienteFirma revisionFirma, String token) async {
    String link = '${apiLink}api/v1/ordenes/${orden.ordenTrabajoId.toString()}/revisiones/${orden.otRevisionId}/firmas/${revisionFirma.otFirmaId}';
    try {
      var headers = {'Authorization': token};
      var resp = await _dio.request(
        link,
        options: Options(
          method: 'DELETE',
          headers: headers,
        ),
      );
      if (resp.statusCode == 204) {
        showDialogs(context, 'Firma borrada', false, false);
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          final responseData = e.response!.data;
          if (responseData != null) {
            final errors = responseData['errors'] as List<dynamic>;
            final errorMessages = errors.map((error) {
              return "Error: ${error['message']}";
            }).toList();
            await _mostrarError(context, errorMessages.join('\n'));
          } else {
            await _mostrarError(context, 'Error: ${e.response!.data}');
          }
        } else {
          await _mostrarError(context, 'Error: ${e.message}');
        }
      }
    }
  }

  Future deleteRevisionFirmaOffline(Orden orden, ClienteFirma revisionFirma) async {
    Revision revision = revisiones.values.where((revision) => revision.otRevisionId == orden.otRevisionId).toList()[0];
    revision.revisionFirma.removeWhere((firma) => firma.otFirmaId == revisionFirma.otFirmaId);
    print('Firma eliminada con éxito');
  }

  Future putRevisionFirma(BuildContext context, Orden orden, ClienteFirma revisionFirma, String token) async {
    String link = apiLink;
    link += 'api/v1/ordenes/${orden.ordenTrabajoId.toString()}/revisiones/${orden.otRevisionId.toString()}/firmas/${revisionFirma.otFirmaId}';
    var data = ({
      "nombre": revisionFirma.nombre,
      "area": revisionFirma.area,
    });
    try {
      var headers = {'Authorization': token};
      var resp = await _dio.request(link,
          options: Options(
            method: 'PUT',
            headers: headers,
          ),
          data: data);
      if (resp.statusCode == 200) {
        showDialogs(context, 'Datos editados', true, false);
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
            await _mostrarError(context, errorMessages.join('\n'));
          } else {
            await _mostrarError(context, 'Error: ${e.response!.data}');
          }
        } else {
          await _mostrarError(context, 'Error: ${e.message}');
        }
      }
    }
  }

}