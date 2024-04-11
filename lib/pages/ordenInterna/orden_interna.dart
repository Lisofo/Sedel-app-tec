// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:app_tecnicos_sedel_wifiless/models/pendiente.dart';
import 'package:app_tecnicos_sedel_wifiless/models/revision.dart';
import 'package:app_tecnicos_sedel_wifiless/models/ubicacion.dart';
import 'package:app_tecnicos_sedel_wifiless/offline/box_func.dart';
import 'package:app_tecnicos_sedel_wifiless/services/materiales_services.dart';
import 'package:app_tecnicos_sedel_wifiless/services/orden_services.dart';
import 'package:app_tecnicos_sedel_wifiless/services/revision_services.dart';
import 'package:app_tecnicos_sedel_wifiless/services/ubicacion_services.dart';
import 'package:app_tecnicos_sedel_wifiless/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:app_tecnicos_sedel_wifiless/config/router/router.dart';
import 'package:app_tecnicos_sedel_wifiless/models/orden.dart';
import 'package:app_tecnicos_sedel_wifiless/providers/menu_providers.dart';
import 'package:app_tecnicos_sedel_wifiless/providers/orden_provider.dart';
import 'package:app_tecnicos_sedel_wifiless/widgets/icons.dart';
import 'package:intl/intl.dart';

import '../../offline/boxes.dart';

class OrdenInterna extends StatefulWidget {
  const OrdenInterna({super.key});

  @override
  State<OrdenInterna> createState() => _OrdenInternaState();
}

class _OrdenInternaState extends State<OrdenInterna> {
  late Orden orden;
  late int marcaId = 0;
  late String _currentPosition = '';
  late Ubicacion ubicacion = Ubicacion.empty();
  bool ejecutando = false;
  String token = '';
  late Revision revision = Revision.empty();
  late Pendiente pendiente = Pendiente.empty();

  @override
  void initState() {
    super.initState();
    orden = context.read<OrdenProvider>().orden;
    marcaId = context.read<OrdenProvider>().marcaId;
    token = context.read<OrdenProvider>().token;
  }

  void _mostrarDialogoConfirmacion(String accion) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmación'),
          content: Text('¿Estás seguro que deseas $accion la orden?'),
          actions: [
            TextButton(
              onPressed: () {
                router.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  if (accion == 'iniciar') {
                    cambiarEstado('EN PROCESO');
                  } else {
                    cambiarEstado('FINALIZADA');
                  }
                });
                router.pop(context);
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 52, 120, 62),
          title: Text(
            'Orden ${orden.ordenTrabajoId}',
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new),
              color: Colors.white,
            )
          ],
        ),
        drawer: Drawer(
          child: Column(
            children: [
              Image.asset('images/sedel.png'),
              const SizedBox(
                height: 25,
              ),
              Expanded(child: _listaItems())
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 52, 120, 62),
                      borderRadius: BorderRadius.circular(5)),
                  height: 30,
                  child: const Center(
                    child: Text(
                      'Detalle',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Nombre del cliente: ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  orden.cliente.nombre,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Codigo del cliente: ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  orden.cliente.codCliente,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Fecha de la orden: ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  DateFormat('EEEEEE d, MMMM yyyy', 'es')
                      .format(orden.fechaOrdenTrabajo),
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Direccion del cliente: ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  orden.cliente.direccion,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Telefono del cliente: ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  orden.cliente.telefono1,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      'Estado: ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      orden.estado,
                      style: const TextStyle(fontSize: 16),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Text(
                      'Tipo de Orden: ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(orden.tipoOrden.descripcion,
                        style: const TextStyle(fontSize: 16))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Servicios: ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                for (var i = 0; i < orden.servicio.length; i++) ...[
                  Text(
                    orden.servicio[i].descripcion,
                    style: const TextStyle(fontSize: 16),
                  )
                ],
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Notas del cliente: ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 52, 120, 62),
                          width: 2),
                      borderRadius: BorderRadius.circular(5)),
                  child: TextFormField(
                    enabled: false,
                    minLines: 1,
                    maxLines: 100,
                    initialValue: orden.cliente.notas,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        fillColor: Colors.white,
                        filled: true),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Instrucciones: ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 52, 120, 62),
                          width: 2),
                      borderRadius: BorderRadius.circular(5)),
                  child: TextFormField(
                    enabled: false,
                    minLines: 1,
                    maxLines: 100,
                    initialValue: orden.instrucciones,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        fillColor: Colors.white,
                        filled: true),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          notchMargin: 10,
          elevation: 0,
          shape: const CircularNotchedRectangle(),
          color: Colors.grey.shade200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                clip: Clip.antiAlias,
                onPressed: marcaId != 0 && orden.estado != 'EN PROCESO'
                    ? () => _mostrarDialogoConfirmacion('iniciar')
                    : null,
                text: 'Iniciar',
                tamano: 18,
                disabled: !(marcaId != 0 && orden.estado == 'PENDIENTE'),
              ),
              CustomButton(
                clip: Clip.antiAlias,
                onPressed: marcaId != 0 && orden.estado == 'EN PROCESO'
                    ? () => _mostrarDialogoConfirmacion('finalizar')
                    : null,
                text: 'Finalizar',
                tamano: 18,
                disabled: !(marcaId != 0 && orden.estado == 'EN PROCESO'),
              ),
              IconButton(
                onPressed: marcaId != 0 && orden.estado == 'EN PROCESO'
                    ? () => volverAPendiente(orden)
                    : null,
                icon: Icon(Icons.backspace,
                    color: marcaId != 0 && orden.estado == 'EN PROCESO'
                        ? const Color.fromARGB(255, 52, 120, 62)
                        : Colors.grey)),
              IconButton(
                tooltip: 'Sincronizar',
                onPressed: () async {
                  sincronizar();
                }, 
                icon: const Icon(Icons.sync, color: Color.fromARGB(255, 52, 120, 62),)
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _listaItems() {
    final String tipoOrden = orden.tipoOrden.codTipoOrden;
    return FutureBuilder(
      future: menuProvider.cargarData(tipoOrden),
      initialData: const [],
      builder: (context, snapshot) {
        return ListView(
          children: _listaItemsDrawer(snapshot.data, context),
        );
      },
    );
  }

  List<Widget> _listaItemsDrawer(data, BuildContext context) {
    final List<Widget> opciones = [];
    data.forEach((opt) {
      final widgetTemp = ListTile(
        title: Text(opt['texto']),
        leading: getIcon(opt['icon']),
        trailing: const Icon(
          Icons.keyboard_arrow_right,
          color: Colors.green,
        ),
        onTap: () {
          Provider.of<OrdenProvider>(context, listen: false).setRevisionOrden(revision);
          router.push(opt['ruta']);
        },
      );

      opciones
        ..add(widgetTemp)
        ..add(const Divider());
    });
    return opciones;
  }

  cambiarEstado(String estado) async {
    if (!ejecutando) {
      ejecutando = true;

      await obtenerUbicacion();
      int ubicacionId = ubicacion.ubicacionId;
      int uId = context.read<OrdenProvider>().uId;

      String token = context.read<OrdenProvider>().token;

      await OrdenServices().patchOrden(context, orden, estado, ubicacionId, token);
      if (estado == 'EN PROCESO') {
        await RevisionServices().postRevision(uId, orden, token);
        revision.otOrdenId = orden.ordenTrabajoId;
        revision.otRevisionId = orden.otRevisionId;
        pendiente.ordenId = orden.ordenTrabajoId;
        pendiente.otRevisionId = orden.otRevisionId;
        addToBoxRevisiones(revision);
        addToBoxPendientes(pendiente);
        
      }
      setState(() {});

      ejecutando = false;
    }
  }

  obtenerUbicacion() async {
    await getLocation();
    int uId = context.read<OrdenProvider>().uId;
    ubicacion.fecha = DateTime.now();
    ubicacion.usuarioId = uId;
    ubicacion.ubicacion = _currentPosition;

    String token = context.read<OrdenProvider>().token;

    await UbicacionServices().postUbicacion(context, ubicacion, token);
  }

  Future<void> getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = '${position.latitude}, ${position.longitude}';
        print('${position.latitude}, ${position.longitude}');
      });
    } catch (e) {
      setState(() {
        _currentPosition = 'Error al obtener la ubicación: $e';
      });
    }
  }

  Future<void> volverAPendiente(Orden orden) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('ADVERTENCIA'),
            content: Text(
              'Todos los datos que hubiera cargado para esta Orden se perderan, Desea pasar a PENDIENTE la Orden ${orden.ordenTrabajoId}?',
              style: const TextStyle(fontSize: 20),
            ),
            actions: [
              TextButton(
                  onPressed: () => GoRouter.of(context).pop(),
                  child: const Text('Cerrar')),
              TextButton(
                  onPressed: () async {
                    if (!ejecutando) {
                      ejecutando = true;
                      await obtenerUbicacion();
                      int ubicacionId = ubicacion.ubicacionId;
                      await OrdenServices().patchOrden(context, orden, 'PENDIENTE', ubicacionId, token);
                      setState(() {});
                      ejecutando = false;
                    }
                    await OrdenServices.showDialogs(context, 'Estado cambiado a Pendiente', true, true);
                    setState(() {});
                  },
                  child: const Text('Confirmar'))
            ],
          );
        });
  }

  Future<void> sincronizar() async {
    if(pendientesBox.isNotEmpty){
      for(var i = 0; i < pendientesBox.length; i++){
        Pendiente pendienteSeleccionada = pendientesBox.getAt(i);
        switch (pendienteSeleccionada.tipo){
          case 5:
            switch (pendienteSeleccionada.accion){
              case 1:
                List<int> plagasIds = [];
                for(var i = 0; i < pendienteSeleccionada.objeto.plagas; i++){
                  plagasIds.add(pendienteSeleccionada.objeto.plagas[i].plagaId);
                }
                await MaterialesServices().postRevisionMaterial(context, orden, plagasIds, pendienteSeleccionada.objeto, token);
              break;
              case 3:
                await MaterialesServices().deleteRevisionMaterial(context, orden, pendienteSeleccionada.objeto, token);
              break;
            }
          break;
          case 6:
            switch(pendienteSeleccionada.accion){
              case 1:
                await RevisionServices().postObservacion(context, orden, pendienteSeleccionada.objeto, token);
              break;
              case 2:
                await RevisionServices().putObservacion(context, orden, pendienteSeleccionada.objeto, token);
              break;
            }
          break;
          
          case 7:
            switch (pendienteSeleccionada.accion){
              case 1:
                await RevisionServices().postRevisionPlaga(context, orden, pendienteSeleccionada.objeto, token);
              break;
              case 3:
                await RevisionServices().deleteRevisionPlaga(context, orden, pendienteSeleccionada.objeto, token);
              break;
            }
          break;
          case 8:
            switch (pendienteSeleccionada.tipo){
              case 1:
                await RevisionServices().postRevisionTarea(context, orden, pendienteSeleccionada.objeto, token);
              break;
              case 3:
                await RevisionServices().deleteRevisionTarea(context, orden, pendienteSeleccionada.objeto, token);
              break;
            }
        }
      }
      await pendientesBox.clear();
      print(pendientesBox.length);
      RevisionServices.showDialogs(context, 'Terminó de sincronizar', false, false);
    }
    
  }
}
