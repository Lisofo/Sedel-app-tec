// ignore_for_file: use_build_context_synchronously

import 'package:app_tecnicos_sedel_wifiless/offline/box_func.dart';
import 'package:app_tecnicos_sedel_wifiless/offline/boxes.dart';
import 'package:app_tecnicos_sedel_wifiless/services/materiales_services.dart';
import 'package:app_tecnicos_sedel_wifiless/services/orden_services.dart';
import 'package:app_tecnicos_sedel_wifiless/services/ptos_services.dart';
import 'package:app_tecnicos_sedel_wifiless/services/revision_services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:app_tecnicos_sedel_wifiless/config/router/router.dart';
import 'package:app_tecnicos_sedel_wifiless/models/orden.dart';
import 'package:app_tecnicos_sedel_wifiless/providers/orden_provider.dart';

class ListaOrdenes extends StatefulWidget {
  const ListaOrdenes({super.key});

  @override
  State<ListaOrdenes> createState() => _ListaOrdenesState();
}

DateTime fecha = DateTime.now();

String fechaHoy = '${fecha.year}-${fecha.month}-${fecha.day}';
String fechaManana = '${fecha.year}-${fecha.month}-${fecha.day + 1}';
List<String> fechas = [fechaHoy, fechaManana, 'Anteriores'];

class _ListaOrdenesState extends State<ListaOrdenes> {
  final ordenServices = OrdenServices();
  String token = '';
  List<Orden> ordenes = [];
  late int tecnicoId = 0;
  int groupValue = 0;
  List trabajodres = [];
  // 1. Agrega una clave global para el RefreshIndicator
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  bool cargando = false;

  List<Orden> get ordenesFiltradas {
    if (groupValue == 0) {
      return ordenes.where((orden) => orden.estado == 'PENDIENTE').toList();
    } else if (groupValue == 1) {
      return ordenes.where((orden) => orden.estado == 'EN PROCESO').toList();
    } else if (groupValue == 2) {
      return ordenes.where((orden) => orden.estado == 'FINALIZADA').toList();
    }
    return [];
  }

  @override
  void initState() {
    super.initState();
    cargarDatos();
  }

  // 2. Método para manejar la actualización de datos
  Future<void> _refreshData() async {
    await cargarDatos();
  }

  cargarDatos() async {
    setState(() {});
    bool isConnected = await _checkConnectivity();
    token = context.read<OrdenProvider>().token;
    tecnicoId = context.read<OrdenProvider>().tecnicoId;
    if(isConnected){
      ordenes = await ordenServices.getOrden(tecnicoId.toString(), opcionActual, opcionActual, token);
      for(int i = 0; i<ordenes.length; i++){
        bool encontrado = false;
        for(int j = 0; j<boxOrdenes.length; j++){
          if(ordenes[i].ordenTrabajoId == boxOrdenes.getAt(j).ordenTrabajoId){
            encontrado = true;
          }
        }
        if(!encontrado){
          addOrdenesToBox(ordenes[i]);
        }
      }
    } else {
      ordenes = await ordenServices.getOrdenesOffline();
    }
    Provider.of<OrdenProvider>(context, listen: false).setOrdenes(ordenes);
    
    for(int i = 0; i<ordenes.length; i++){
      cargando = true;
      if(ordenes[i].otRevisionId != 0){
        ordenes[i].revision?.otRevisionId = ordenes[i].otRevisionId;
        ordenes[i].revision?.otOrdenId = ordenes[i].ordenTrabajoId;
        ordenes[i].revision?.revisionPlaga = await RevisionServices().getRevisionPlagas(ordenes[i], token);
        ordenes[i].revision?.revisionTarea = await RevisionServices().getRevisionTareas(ordenes[i], token);
        ordenes[i].revision?.revisionMaterial = await MaterialesServices().getRevisionMateriales(ordenes[i], token);
        ordenes[i].revision?.revisionObservacion = await RevisionServices().getObservacion(ordenes[i], token);
        // ordenes[i].revision?.revisionFirma = await RevisionServices().getRevisionFirmas(ordenes[i], token);
        ordenes[i].revision?.revisionPtoInspeccion = await PtosInspeccionServices().getPtosInspeccion(context, ordenes[i], token);
        // addToBoxRevisiones(ordenes[i].revision);
      }
    }
    cargando = false; 

    setState(() {});
  }

  Future<bool> _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
  String opcionActual = fechas[0];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 52, 120, 62),
          title: const Text(
            'Lista de Ordenes',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return AlertDialog(
                          title: const Text('Cambiar de fechas'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              RadioListTile(
                                title: Text(fechas[0]),
                                value: fechas[0],
                                groupValue: opcionActual,
                                onChanged: (value) {
                                  setState(() {
                                    opcionActual = value.toString();
                                  });
                                },
                              ),
                              RadioListTile(
                                title: Text(fechas[1]),
                                value: fechas[1],
                                groupValue: opcionActual,
                                onChanged: (value) {
                                  setState(() {
                                    opcionActual = value.toString();
                                  });
                                },
                              ),
                              RadioListTile(
                                title: Text(fechas[2]),
                                value: fechas[2],
                                groupValue: opcionActual,
                                onChanged: (value) {
                                  setState(() {
                                    opcionActual = value.toString();
                                  });
                                },
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Cancelar'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('Confirmar'),
                              onPressed: () {
                                cargarDatos();
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.date_range_rounded,
                color: Colors.white,
              ),
            )
          ],
        ),
        backgroundColor: Colors.grey.shade200,
        body: Column(
          children: [
            CupertinoSegmentedControl<int>(
              padding: const EdgeInsets.all(10),
              groupValue: groupValue,
              borderColor: Colors.black,
              selectedColor: const Color.fromARGB(255, 52, 120, 62),
              unselectedColor: Colors.white,
              children: {
                0: buildSegment('Pendiente'),
                1: buildSegment('En Proceso'),
                2: buildSegment('Finalizado'),
              },
              onValueChanged: (newValue) {
                setState(() {
                  groupValue = newValue;
                });
              },
            ),
            Expanded(
              child: RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: _refreshData,
                child: cargando ? const Center(child: CircularProgressIndicator()) : ListView.builder(
                  itemCount: ordenesFiltradas.length,
                  itemBuilder: (context, i) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: const BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      elevation: 20,
                      child: InkWell(
                        onTap: () {
                          final orden = ordenesFiltradas[i];
                          context.read<OrdenProvider>().setOrden(orden);

                          router.push('/ordenInterna');
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    ordenesFiltradas[i].ordenTrabajoId.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    DateFormat('EEEEEE d, MMMM yyyy', 'es').format(ordenesFiltradas[i].fechaOrdenTrabajo),
                                  ),
                                  const Expanded(child: Text('')),
                                  Text(ordenesFiltradas[i].tipoOrden.descripcion),
                                ],
                              ),
                              Text(
                                '${ordenesFiltradas[i].cliente.codCliente} - ${ordenesFiltradas[i].cliente.nombre}',
                              ),
                              Text(ordenesFiltradas[i].cliente.direccion),
                              Text(ordenesFiltradas[i].cliente.telefono1),
                              Text(ordenesFiltradas[i].cliente.notas),
                              Text(ordenesFiltradas[i].instrucciones),
                              for (var j = 0; j < ordenesFiltradas[i].servicio.length; j++) ...[
                                Text(ordenesFiltradas[i].servicio[j].descripcion,)
                              ],
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSegment(String text) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Text(
        text,
        style: const TextStyle(fontSize: 15),
      ),
    );
  }
}
