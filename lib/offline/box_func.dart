import 'package:app_tecnicos_sedel_wifiless/models/material.dart';
import 'package:app_tecnicos_sedel_wifiless/models/plaga_objetivo.dart';
import 'package:app_tecnicos_sedel_wifiless/models/revision.dart';
import 'package:app_tecnicos_sedel_wifiless/models/tarea.dart';
import 'package:app_tecnicos_sedel_wifiless/models/tipos_ptos_inspeccion.dart';

import '../models/lote.dart';
import '../models/metodo_aplicacion.dart';
import '../models/pendiente.dart';
import 'boxes.dart';
import 'package:app_tecnicos_sedel_wifiless/models/orden.dart';
import 'package:app_tecnicos_sedel_wifiless/models/plaga.dart';

Future<void> addOrdenesToBox(Orden orden) async {
  await boxOrdenes.add(orden);
}

Future<void> addListasToBoxCodiguera(
  Plaga? plaga, Tarea? tarea, Materiales? materiales, Lote? lote, MetodoAplicacion? metodoAplicacion, PlagaObjetivo? plagaObjetivo, TipoPtosInspeccion? tipoPtosInspeccion ) async {
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
  if(plagaObjetivo != null){
    await codigueras.add(plagaObjetivo);
  }
  if(tipoPtosInspeccion != null){
    await codigueras.add(tipoPtosInspeccion);
  }
  
}

Future<void> addToBoxRevisiones(Revision? revision) async{
  revisiones.put('${revision?.otOrdenId}', revision);
}

Future<void> addToBoxPendientes(Pendiente pendiente) async {
  await boxPendientes.put('${pendiente.ordenId}',pendiente);
}