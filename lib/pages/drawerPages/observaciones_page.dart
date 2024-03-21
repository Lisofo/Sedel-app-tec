// ignore_for_file: avoid_print, use_build_context_synchronously, void_checks

import 'package:app_tecnicos_sedel_wifiless/models/observacion.dart';
import 'package:app_tecnicos_sedel_wifiless/models/orden.dart';
import 'package:app_tecnicos_sedel_wifiless/offline/boxes.dart';
import 'package:app_tecnicos_sedel_wifiless/providers/orden_provider.dart';
import 'package:app_tecnicos_sedel_wifiless/services/revision_services.dart';
import 'package:app_tecnicos_sedel_wifiless/widgets/custom_button.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/revision.dart';

class ObservacionesPage extends StatefulWidget {
  const ObservacionesPage({super.key});

  @override
  State<ObservacionesPage> createState() => _ObservacionesPageState();
}

class _ObservacionesPageState extends State<ObservacionesPage> {
  final observacionController = TextEditingController();
  final comentarioInternoController = TextEditingController();
  late Observacion observacion = Observacion.empty();
  late Orden orden = Orden.empty();
  late String token = '';
  late List<Observacion> observaciones = [];
  late int marcaId = 0;
  late Revision revision = Revision.empty();
  
  @override
  void initState() {
    super.initState();
    cargarDatos();
  }

  cargarDatos() async {
    bool isConnected = await _checkConnectivity();
    orden = context.read<OrdenProvider>().orden;
    token = context.read<OrdenProvider>().token;
    marcaId = context.read<OrdenProvider>().marcaId;
    revision = revisiones.values.where((revision) => revision.otRevisionId == orden.otRevisionId).toList()[0];
    if(isConnected){
      observaciones = await RevisionServices().getObservacion(orden, token);
      if(orden.revision.revisionObservacion.isEmpty){
        for (var obs in observaciones) {
          orden.revision.revisionObservacion.add(obs);
        }
      }
    if (observaciones.isNotEmpty) {
      observacion = observaciones[0];
    } else {
      observacion = Observacion.empty();
    }
    }else{
      if(revision.revisionObservacion.isNotEmpty){
        observacion = revision.revisionObservacion[0];
      }
      else{
        observacion = Observacion.empty();
      }
    }

    setState(() {
      observacionController.text = observacion.observacion;
      comentarioInternoController.text = observacion.comentarioInterno; 
    });
  }

  Future<bool> _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(
          '${orden.ordenTrabajoId} - Observaciones',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 52, 120, 62),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 52, 120, 62), width: 2),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  controller: observacionController,
                  maxLines: 6,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    fillColor: Colors.white,
                    filled: true
                  ),
                  enabled: marcaId != 0,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Comentario interno:',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 52, 120, 62), width: 2),
                  borderRadius: BorderRadius.circular(5),
                  // color: Colors.white
                ),
                child: TextFormField(
                  controller: comentarioInternoController,
                  maxLines: 6,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    fillColor: Colors.white,
                    filled: true
                  ),
                  enabled: marcaId != 0,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.center,
                child: CustomButton(
                  onPressed: () async {
                    if(marcaId == 0){
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Marque entrada antes de ingresar datos.'),
                      ));
                      return Future.value(false);
                    }
                    await guardarObservaciones();
                  },
                  text: 'Guardar',
                  tamano: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  guardarObservaciones() async {
    bool isConnected = await _checkConnectivity();
    observacion.comentarioInterno = comentarioInternoController.text;
    observacion.observacion = observacionController.text;
    observacion.obsRestringida = observacionController.text;
    if(isConnected){
      if (observacion.otObservacionId == 0) {
        revision.revisionObservacion[0] = observacion;
        await RevisionServices().postObservacion(context, orden, observacion, token);
      } else {
        await RevisionServices().putObservacion(context, orden, observacion, token);
      }
    }
    
  }
}
