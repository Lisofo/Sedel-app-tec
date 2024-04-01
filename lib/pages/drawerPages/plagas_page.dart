// ignore_for_file: use_build_context_synchronously, void_checks

import 'package:app_tecnicos_sedel_wifiless/config/router/router.dart';
import 'package:app_tecnicos_sedel_wifiless/models/grado_infestacion.dart';
import 'package:app_tecnicos_sedel_wifiless/models/orden.dart';
import 'package:app_tecnicos_sedel_wifiless/models/plaga.dart';
import 'package:app_tecnicos_sedel_wifiless/models/revision.dart';
import 'package:app_tecnicos_sedel_wifiless/models/revision_plaga.dart';
import 'package:app_tecnicos_sedel_wifiless/offline/box_func.dart';
import 'package:app_tecnicos_sedel_wifiless/offline/boxes.dart';
import 'package:app_tecnicos_sedel_wifiless/providers/orden_provider.dart';
import 'package:app_tecnicos_sedel_wifiless/services/plagas_services.dart';
import 'package:app_tecnicos_sedel_wifiless/services/revision_services.dart';
import 'package:app_tecnicos_sedel_wifiless/widgets/custom_button.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlagasPage extends StatefulWidget {
  const PlagasPage({super.key});

  @override
  State<PlagasPage> createState() => _PlagasPageState();
}

class _PlagasPageState extends State<PlagasPage> {
  List<Plaga> plagas = [];

  List<GradoInfestacion> gradoInfeccion = [
    GradoInfestacion(
        gradoInfestacionId: 1,
        codGradoInfestacion: '1',
        descripcion: 'Sin Avistamiento'),
    GradoInfestacion(
        gradoInfestacionId: 2,
        codGradoInfestacion: '2',
        descripcion: 'Población Controlada - Aceptable'),
    GradoInfestacion(
        gradoInfestacionId: 3,
        codGradoInfestacion: '3',
        descripcion: 'Población Media - Requiere Atención'),
    GradoInfestacion(
        gradoInfestacionId: 4,
        codGradoInfestacion: '4',
        descripcion: 'Población Alta - Grave'),
  ];
  List<Plaga> plagasSeleccionadas = [];
  late Plaga selectedPlaga = Plaga.empty();
  List<GradoInfestacion> gradosSeleccionados = [];
  GradoInfestacion selectedGrado = GradoInfestacion.empty();
  final ScrollController _scrollController = ScrollController();
  late String token = '';
  late Orden orden = Orden.empty();
  late List<RevisionPlaga> revisionPlagasList = [];
  // bool isReadOnly = true;
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
    // if (orden.estado == "EN PROCESO" && marcaId != 0) {
    //   isReadOnly = false;
    // }
    
    if(isConnected){
      plagas = await PlagaServices().getPlagas(token);
      revisionPlagasList = await RevisionServices().getRevisionPlagas(orden, token);
      if(codigueras.values.whereType<Plaga>().toList().isEmpty){
        for(int i = 0; i<plagas.length; i++){
          addListasToBoxCodiguera(plagas[i], null, null, null, null);
        }
      }
      if(orden.revision!.revisionPlaga.isEmpty){
        for (var plaga in revisionPlagasList) {
          orden.revision!.revisionPlaga.add(plaga);
        }
      } 
    }else{
      plagas = await PlagaServices().getPlagasOffline();
      revisionPlagasList = revision.revisionPlaga;
    }
    
    setState(() {});
  }
  
  Future<bool> _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 52, 120, 62),
        title: Text(
          '${orden.ordenTrabajoId} - Plagas',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 2,
                            color: const Color.fromARGB(255, 52, 120, 62)),
                        borderRadius: BorderRadius.circular(5)),
                    child: DropdownSearch(
                      items: plagas,
                      popupProps: const PopupProps.menu(
                          showSearchBox: true, searchDelay: Duration.zero),
                      onChanged: (value) {
                        setState(() {
                          selectedPlaga = value;
                        });
                      },
                    )),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: const Color.fromARGB(255, 52, 120, 62)
                    ),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: DropdownSearch(
                    items: gradoInfeccion,
                    popupProps: const PopupProps.menu(
                      showSearchBox: true, 
                      searchDelay: Duration.zero
                    ),
                    onChanged: (value) {
                      setState(() {
                        selectedGrado = value;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
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
                        bool agregarPlaga = true;
                        if (revisionPlagasList.isNotEmpty) {
                          agregarPlaga = !revisionPlagasList.any((plaga) =>
                              plaga.plagaId == selectedPlaga.plagaId);
                        }
                        if (agregarPlaga && selectedGrado.gradoInfestacionId != 0) {
                          await posteoRevisionPlaga(context);
                          setState(() {});
                        }
                      },
                      text: 'Agregar +',
                      tamano: 20,
                    ),
                  ],
                ),
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
                        await posteoDeBox(context);
                      },
                      text: 'Sincronizar',
                      tamano: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Container(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.6),
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: revisionPlagasList.length,
                      itemBuilder: (context, index) {
                        final item = revisionPlagasList[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Dismissible(
                            key: Key(item.toString()),
                            direction: DismissDirection.endToStart,
                            confirmDismiss: (DismissDirection direction) {
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
                                      content: const Text(
                                          "¿Estas seguro de querer borrar la plaga?"),
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
                                              Navigator.of(context).pop(true);
                                              await RevisionServices().deleteRevisionPlaga(context,orden,revisionPlagasList[index],token);
                                            },
                                            child: const Text("BORRAR")),
                                      ],
                                    );
                                  });
                            },
                            onDismissed: (direction) async {
                              setState(() {
                                revisionPlagasList.removeAt(index);
                              });
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('La plaga $item ha sido borrada'),
                              ));
                            },
                            background: Container(
                              color: Colors.red,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              alignment: AlignmentDirectional.centerEnd,
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            child: Container(
                              decoration: const BoxDecoration(
                                  border: Border(bottom: BorderSide())),
                              child: ListTile(
                                title: Text(revisionPlagasList[index].plaga),
                                subtitle: Text(revisionPlagasList[index].gradoInfestacion),
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
                                          content: Text("¿Estas seguro de querer borrar la plaga ${revisionPlagasList[index].plaga}?"),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.of(context).pop(false),
                                              child: const Text("CANCELAR"),
                                            ),
                                            TextButton(
                                              style: TextButton.styleFrom(foregroundColor:Colors.red,),
                                              onPressed: () async {
                                                await borrarPlaga(context, index);
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
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          // if (isReadOnly)
          //   IgnorePointer(
          //     ignoring: false,
          //     child: Container(
          //       color: Colors.grey.withOpacity(0.6),
          //     ),
          //   ),
        ],
      ),
    );
  }

  Future<void> borrarPlaga(BuildContext context, int i) async {
    bool isConnected = await _checkConnectivity();
    if(isConnected){
      await RevisionServices().deleteRevisionPlagaOffline(revisionPlagasList[i], orden);
      await RevisionServices().deleteRevisionPlaga(context, orden, revisionPlagasList[i], token);
    }else{
      await RevisionServices().deleteRevisionPlagaOffline(revisionPlagasList[i], orden);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('La plaga ${revisionPlagasList[i].plaga} ha sido borrada'),
        )
      );  
      router.pop(context);
    }
    revisionPlagasList.removeAt(i);
    setState(() {});
  }

  Future<void> posteoRevisionPlaga(BuildContext context) async {
    bool isConnected = await _checkConnectivity();
    Revision revisionSeleccionada = revisiones.values.where((revision) => revision.otRevisionId == orden.otRevisionId).toList()[0];
    var nuevaPlaga = RevisionPlaga(
      otPlagaId: 0,
      ordenTrabajoId: orden.ordenTrabajoId,
      otRevisionId: orden.otRevisionId,
      comentario: '',
      plagaId: selectedPlaga.plagaId,
      codPlaga: selectedPlaga.codPlaga,
      plaga: selectedPlaga.descripcion,
      gradoInfestacionId: selectedGrado.gradoInfestacionId,
      codGradoInfestacion: selectedGrado.codGradoInfestacion,
      gradoInfestacion: selectedGrado.descripcion
    );

    if(isConnected){
      revisionSeleccionada.revisionPlaga.add(nuevaPlaga);
      await RevisionServices().postRevisionPlaga(context, orden, nuevaPlaga, token);
      revisionPlagasList.add(nuevaPlaga);
      RevisionServices.showDialogs(context, 'Plaga guardada', false, false);
    }else{
      revisionSeleccionada.revisionPlaga.add(nuevaPlaga);
    }
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 200,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  Future<void> posteoDeBox(BuildContext context) async {
    bool isConnected = await _checkConnectivity();
    Revision revisionSeleccionada = revisiones.values.where((revision) => revision.otRevisionId == orden.otRevisionId).toList()[0];

    for(int i = 0; i < revisionSeleccionada.revisionPlaga.length; i++){
      var post = revisionSeleccionada.revisionPlaga[i];
      if(post.otPlagaId != 0){
        await RevisionServices().postRevisionPlaga(context, orden, post, token);
      }
    }
    RevisionServices.showDialogs(context, 'Plaga guardada', false, false);
  }
}
