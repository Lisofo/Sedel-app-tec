import 'package:app_tecnicos_sedel_wifiless/models/material.dart';
import 'package:app_tecnicos_sedel_wifiless/models/revision.dart';
import 'package:app_tecnicos_sedel_wifiless/models/tarea.dart';

import '../models/lote.dart';
import '../models/metodo_aplicacion.dart';
import 'boxes.dart';
import 'package:app_tecnicos_sedel_wifiless/models/orden.dart';
import 'package:app_tecnicos_sedel_wifiless/models/plaga.dart';

Future<void> addOrdenesToBox(Orden orden) async {
  await boxOrdenes.add(orden);
}

Future<void> addListasToBoxCodiguera(
  Plaga? plaga, Tarea? tarea, Materiales? materiales, Lote? lote, MetodoAplicacion? metodoAplicacion ) async {
  if(plaga != null){
    await codigueras.add(plaga);
  }
  if(tarea != null){
    await codigueras.add(tarea);
  }
  if(materiales != null){
    await codigueras.add(materiales);
  }
  if(lote != null){
    await codigueras.add(lote);
  }
  if(metodoAplicacion != null){
    await codigueras.add(metodoAplicacion);
  }
  
}

Future<void> addToBoxRevisiones(Revision revision) async{
  revisiones.put('Key: ${revision.otOrdenId}', revision);
}

