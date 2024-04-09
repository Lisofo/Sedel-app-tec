// ignore_for_file: use_build_context_synchronously, void_checks, unused_local_variable

import 'package:app_tecnicos_sedel_wifiless/config/router/router.dart';
import 'package:app_tecnicos_sedel_wifiless/models/orden.dart';
import 'package:app_tecnicos_sedel_wifiless/models/pendiente.dart';
import 'package:app_tecnicos_sedel_wifiless/models/revision_tarea.dart';
import 'package:app_tecnicos_sedel_wifiless/models/tarea.dart';
import 'package:app_tecnicos_sedel_wifiless/offline/box_func.dart';
import 'package:app_tecnicos_sedel_wifiless/offline/boxes.dart';
import 'package:app_tecnicos_sedel_wifiless/providers/orden_provider.dart';
import 'package:app_tecnicos_sedel_wifiless/services/revision_services.dart';
import 'package:app_tecnicos_sedel_wifiless/services/tareas_services.dart';
import 'package:app_tecnicos_sedel_wifiless/widgets/custom_button.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/revision.dart';

class TareasPage extends StatefulWidget {
  const TareasPage({super.key});

  @override
  State<TareasPage> createState() => _TareasPageState();
}

class _TareasPageState extends State<TareasPage> {
  List<Tarea> tareas = [];
  late String token = '';
  final ScrollController _scrollController = ScrollController();
  List<Tarea> tareasSeleccionadas = [];
  Tarea selectedTarea = Tarea.empty();
  late Orden orden = Orden.empty();
  late List<RevisionTarea> revisionTareasList = [];
  late int marcaId = 0;
  late Revision revision = Revision.empty();


  @override
  void initState() {
    super.initState();
    cargarDatos();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  cargarDatos() async {
    bool isConnected = await _checkConnectivity();
    token = context.read<OrdenProvider>().token;
    orden = context.read<OrdenProvider>().orden;
    marcaId = context.read<OrdenProvider>().marcaId;
    revision = revisiones.values.where((revision) => revision.otRevisionId == orden.otRevisionId).toList()[0];

    if(isConnected){
      tareas = await TareasServices().getTareas(token);
      revisionTareasList = await RevisionServices().getRevisionTareas(orden, token);
      if(codigueras.values.whereType<Tarea>().toList().isEmpty){
        for(int i = 0; i<tareas.length; i++){
          addListasToBoxCodiguera(null, tareas[i], null, null, null, null, null);
        }
      }
      if(orden.revision!.revisionPlaga.isEmpty){
        for (var tarea in revisionTareasList) {
          orden.revision?.revisionTarea.add(tarea);
        }
      }
    }else{
      tareas = await TareasServices().getTareasOffline();
      revisionTareasList = revision.revisionTarea;
    }

    setState(() {});
  }

  Future<bool> _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 52, 120, 62),
          title: Text('${orden.ordenTrabajoId} - Tareas Realizadas',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1, color: const Color.fromARGB(255, 52, 120, 62)),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: DropdownSearch(
                    items: tareas,
                    popupProps: const PopupProps.menu(
                      showSearchBox: true, searchDelay: Duration.zero),
                    onChanged: (value) {
                      setState(() {
                        selectedTarea = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      onPressed: () async {
                        if(marcaId == 0){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Marque entrada antes de ingresar datos.'),
                          ));
                          return Future.value(false);
                        }
                        bool agregarTarea = true;
                        if (revisionTareasList.isNotEmpty) {
                          agregarTarea = !revisionTareasList.any((tarea) => tarea.tareaId == selectedTarea.tareaId);
                        }
                        if (agregarTarea) {
                          await posteoRevisionTarea(context);
                          setState(() {});
                        }
                      },
                      text: 'Agregar +',
                      tamano: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.6),
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: revisionTareasList.length,
                    itemBuilder: (context, i) {
                      final item = revisionTareasList[i];
                      return Dismissible(
                        key: Key(item.toString()),
                        direction: DismissDirection.endToStart,
                        confirmDismiss: (DismissDirection direction) async {
                          bool isConnected = await _checkConnectivity();
                          if(marcaId == 0){
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('Marque entrada antes de ingresar datos.'),
                            ));
                            return Future.value(false);
                          }
                          return showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Confirmar"),
                                content: const Text("¿Estas seguro de querer borrar la tarea?"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                      Navigator.of(context).pop(false),
                                    child: const Text("CANCELAR"),
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.red,
                                    ),
                                    onPressed: () async {
                                      if(isConnected){
                                        Navigator.of(context).pop(true);
                                        await RevisionServices().deleteRevisionTareaOffline(revisionTareasList[i], orden);
                                        await RevisionServices().deleteRevisionTarea(context, orden, revisionTareasList[i], token);
                                      }else{
                                        await RevisionServices().deleteRevisionTareaOffline(revisionTareasList[i], orden);
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          content: Text('La tarea ${revisionTareasList[i].descripcion} ha sido borrada'),
                                        ));
                                        router.pop(context);
                                      }
                                    },
                                    child: const Text("BORRAR")
                                  ),
                                ],
                              );
                            }
                          );
                        },
                        onDismissed: (direction) async {
                          setState(() {
                            revisionTareasList.removeAt(i);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('La tarea $item ha sido borrada'),
                          ));
                        },
                        background: Container(
                          color: Colors.red,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          alignment: AlignmentDirectional.centerEnd,
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        child: Container(
                          decoration: const BoxDecoration(border: Border(bottom: BorderSide())),
                          child: ListTile(
                            title: Text(revisionTareasList[i].descripcion),
                            trailing: IconButton(
                              onPressed: () async {
                                if(marcaId == 0){
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                    content: Text('Marque entrada antes de ingresar datos.'),
                                  ));
                                  return Future.value(false);
                                }
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Confirmar"),
                                      content: const Text("¿Estas seguro de querer borrar la tarea?"),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () => Navigator.of(context).pop(false),
                                          child: const Text("CANCELAR"),
                                        ),
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.red,
                                          ),
                                          onPressed: () async {
                                            await borrarTarea(context, revisionTareasList[i]);
                                          },
                                          child: const Text("BORRAR")
                                        ),
                                      ],
                                    );
                                  }
                                );
                              },
                              icon: const Icon(Icons.delete)
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> borrarTarea(BuildContext context, RevisionTarea tarea) async {
    bool isConnected = await _checkConnectivity();
    if(isConnected){
      RevisionTarea tareaABorrar = revision.revisionTarea.firstWhere((element) => element.otTareaId == tarea.otTareaId);
      await RevisionServices().deleteRevisionTareaOffline(tareaABorrar, orden);
      await RevisionServices().deleteRevisionTarea(context, orden, tarea, token);
    }else{
      if(tarea.otTareaId == 0){
        pendientesBox.delete(tarea.hiveKey);
      } else {
        Pendiente pendienteABorrar = Pendiente.empty();
        pendienteABorrar.accion = 3;
        pendienteABorrar.objeto = tarea;
        pendienteABorrar.ordenId = orden.ordenTrabajoId;
        pendienteABorrar.otRevisionId = orden.otRevisionId;
        pendienteABorrar.tipo = 8;  
      }
      await RevisionServices().deleteRevisionTareaOffline(tarea, orden);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('La tarea ${tarea.descripcion} ha sido borrada'),
      ));
    }
    router.pop(context);
    setState(() {});
  }

  Future<void> posteoRevisionTarea(BuildContext context) async {
    bool isConnected = await _checkConnectivity();
    Revision revisionSeleccionada = revisiones.values.where((revision) => revision.otRevisionId == orden.otRevisionId).toList()[0];
    late Pendiente pendiente = Pendiente.empty();
    var nuevaTarea = RevisionTarea(
      otTareaId: 0,
      ordenTrabajoId: orden.ordenTrabajoId,
      otRevisionId: orden.otRevisionId,
      tareaId: selectedTarea.tareaId,
      codTarea: selectedTarea.codTarea,
      descripcion: selectedTarea.descripcion,
      comentario: '',
      hiveKey: 0
    );
    pendiente.objeto = nuevaTarea;
    pendiente.accion = 1;
    pendiente.ordenId = orden.ordenTrabajoId;
    pendiente.otRevisionId = orden.otRevisionId;
    pendiente.tipo = 8;

    if(isConnected){
      revisionSeleccionada.revisionTarea.add(nuevaTarea);
      await RevisionServices().postRevisionTarea(context, orden, nuevaTarea, token);
      RevisionServices.showDialogs(context, 'Tarea guardada', false, false);
      // revisionTareasList.add(nuevaTarea);
    }else{
      revisionSeleccionada.revisionTarea.add(nuevaTarea);
      int hiveKeySelected = await addToBoxPendientes(pendiente);
      Pendiente objetoPendienteSeleccionado = pendientesBox.get(hiveKeySelected);
      objetoPendienteSeleccionado.objeto.hiveKey = hiveKeySelected;
    }    
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 200,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
