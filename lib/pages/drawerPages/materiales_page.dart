// ignore_for_file: use_build_context_synchronously, avoid_init_to_null, void_checks, unused_local_variable, unrelated_type_equality_checks

import 'package:app_tecnicos_sedel_wifiless/config/router/router.dart';
import 'package:app_tecnicos_sedel_wifiless/models/material.dart';
import 'package:app_tecnicos_sedel_wifiless/models/orden.dart';
import 'package:app_tecnicos_sedel_wifiless/models/pendiente.dart';
import 'package:app_tecnicos_sedel_wifiless/models/plaga.dart';
import 'package:app_tecnicos_sedel_wifiless/models/revision_materiales.dart';
import 'package:app_tecnicos_sedel_wifiless/offline/box_func.dart';
import 'package:app_tecnicos_sedel_wifiless/offline/boxes.dart';
import 'package:app_tecnicos_sedel_wifiless/providers/orden_provider.dart';
import 'package:app_tecnicos_sedel_wifiless/services/materiales_services.dart';
import 'package:app_tecnicos_sedel_wifiless/services/plagas_services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/lote.dart';
import '../../models/metodo_aplicacion.dart';
import '../../models/revision.dart';

class MaterialesPage extends StatefulWidget {
  const MaterialesPage({super.key});

  @override
  State<MaterialesPage> createState() => _MaterialesPageState();
}

class _MaterialesPageState extends State<MaterialesPage> {
  late List<String> savedData = [];
  List<Materiales> materiales = [];
  List<MetodoAplicacion> metodosAplicacion = [];
  late List<Lote>? lotes = [];
  late List<Plaga> plagas = [];
  late List<Plaga> plagasSeleccionadas = [];
  late List<RevisionMaterial> revisionMaterialesList = [];
  late Materiales selectedMaterial = Materiales.empty();
  late Lote? selectedLote = Lote.empty();
  late String cantidad = '';
  late String ubicacion = '';
  late String areaCobertura = '';
  late MetodoAplicacion? selectedMetodo;
  late String token = '';
  late Materiales? materialInicial = null;
  late Orden orden = Orden.empty();
  final ScrollController _scrollController = ScrollController();
  late int marcaId = 0;
  late Revision revision = Revision.empty();

  @override
  void initState() {
    super.initState();
    cargarDatos();
  }

  cargarDatos() async {
    bool isConnected = await _checkConnectivity();
    token = context.read<OrdenProvider>().token;
    orden = context.read<OrdenProvider>().orden;
    marcaId = context.read<OrdenProvider>().marcaId;
    revision = revisiones.values.where((revision) => revision.otRevisionId == orden.otRevisionId).toList()[0];
    
    if(isConnected){
      materiales = await MaterialesServices().getMaterialesConLotes(token);
      metodosAplicacion = await MaterialesServices().getMetodosAplicacion(token);
      revisionMaterialesList = await MaterialesServices().getRevisionMateriales(orden, token);
      if(codigueras.values.whereType<Materiales>().toList().isEmpty){
        for(int i = 0; i < materiales.length; i++){
          addListasToBoxCodiguera(null, null, materiales[i], null, null, null, null);
        }
      }

      for(int i = 0; i < metodosAplicacion.length; i++){
        addListasToBoxCodiguera(null, null, null, null, metodosAplicacion[i], null, null);
      }

      if(orden.revision!.revisionMaterial.isEmpty){
        for (var material in revisionMaterialesList) {
          orden.revision!.revisionMaterial.add(material);
        } 
      }

    }else{
      materiales = await MaterialesServices().getMaterialesOffline(token);
      revisionMaterialesList = revision.revisionMaterial;
    }

    setState(() {});
  }

  Future<bool> _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  void _showMaterialDetails(BuildContext context, Materiales material) async {
    bool isConnected = await _checkConnectivity();
    if(isConnected){
      plagas = await PlagaServices().getPlagas(token);
      lotes = await MaterialesServices().getLotes(selectedMaterial.materialId, token);
      
    }else{
      plagas = await PlagaServices().getPlagasOffline(); 
      lotes = selectedMaterial.lotes;
      metodosAplicacion = await MaterialesServices().getMetodosAplicacionOffline();
    }


    selectedMetodo = MetodoAplicacion.empty();
    selectedLote = Lote.empty();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Nombre: ${material.descripcion}',
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  'Unidad: ${material.unidad}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                const Text('Cantidad:'),
                TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    cantidad = value;
                  },
                ),
                const SizedBox(height: 16),
                const Text('Lote:'),
                DropdownSearch(
                  items: lotes!,
                  onChanged: (newValue) {
                    setState(() {
                      selectedLote = newValue;
                    });
                  },
                ),
                const SizedBox(height: 16),
                const Text('Método de Aplicación:'),
                DropdownSearch(
                  items: metodosAplicacion,
                  onChanged: (newValue) {
                    setState(() {
                      selectedMetodo = newValue;
                    });
                  },
                ),
                const SizedBox(height: 16,),
                const Text('Plagas:'),
                DropdownSearch<Plaga>.multiSelection(
                  items: plagas,
                  popupProps: const PopupPropsMultiSelection.menu(
                    // showSelectedItems: true,
                    // disabledItemFn: (String s) => s.startsWith('I'),
                    ),
                  onChanged: (value) {
                    plagasSeleccionadas = (value);
                  },
                ),
                const SizedBox(height: 16),
                const Text('Ubicación:'),
                TextField(
                  onChanged: (value) {
                    ubicacion = value;
                  },
                ),
                const SizedBox(height: 16),
                const Text('Área de Cobertura:'),
                TextField(
                  onChanged: (value) {
                    areaCobertura = value;
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
                child: const Text('Guardar'),
                onPressed: () async {
                  bool agregarMaterial = true;
                  if (revisionMaterialesList.isNotEmpty) {
                    agregarMaterial = !revisionMaterialesList.any((material) => material.material.materialId == selectedMaterial.materialId);
                  }
                  if(agregarMaterial){
                    await posteoRevisionMateriales(material, context);
                  }
                  router.pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (selectedMaterial.materialId != 0 && materiales.isNotEmpty) {
      materialInicial = materiales.firstWhere((material) => material.materialId == selectedMaterial.materialId);
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('${orden.ordenTrabajoId} - Materiales',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 52, 120, 62),
        ),
        backgroundColor: Colors.grey.shade200,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 2,
                        color: const Color.fromARGB(255, 52, 120, 62)),
                    borderRadius: BorderRadius.circular(5)),
                child: DropdownButton<Materiales>(
                  hint: const Text("Selecciona un material"),
                  value: materialInicial,
                  onChanged: (newValue) async {
                    if(marcaId == 0){
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Marque entrada antes de ingresar datos.'),
                      ));
                      return Future.value(false);
                    }
                    setState(() {
                      selectedMaterial = newValue!;
                      _showMaterialDetails(context, selectedMaterial);
                    });
                  },
                  items: materiales.map((material) {
                    return DropdownMenuItem(
                      value: material,
                      child: Text(material.descripcion),
                    );
                  }).toList(),
                  iconSize: 24,
                  elevation: 16,
                  isExpanded: true,
                ),
              ),
              const SizedBox(height: 20,),
              Expanded(
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
                          'Materiales Utilizados:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        controller: _scrollController,
                        itemCount: revisionMaterialesList.length,
                        itemBuilder: (context, i) {
                          final material = revisionMaterialesList[i];
                          return Dismissible(
                            key: Key(material.toString()),
                            direction: DismissDirection.endToStart,
                            confirmDismiss: (DismissDirection direction) async {
                              if(marcaId == 0){
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text('Marque entrada antes de ingresar datos.'),
                                ));
                                return Future.value(false);
                              }
                              return await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Confirmar"),
                                    content: const Text("¿Estas seguro de querer borrar el material?"),
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
                                          await borrarMaterial(context, revisionMaterialesList[i]);
                                        },
                                        child: const Text("BORRAR")
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            onDismissed: (direction) {
                              setState(() {
                                revisionMaterialesList.removeAt(i);
                              });
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('$material borrado'),
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
                            child: Card(
                              child: ListTile(
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
                                            content: const Text(
                                                "¿Estas seguro de querer borrar el material?"),
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
                                                  await MaterialesServices().deleteRevisionMaterial(context,orden,revisionMaterialesList[i],token);
                                                  setState(() {
                                                    revisionMaterialesList.removeAt(i);
                                                  });
                                                },
                                                child: const Text("BORRAR")
                                              ),
                                            ],
                                          );
                                        }
                                      );
                                    },
                                    icon: const Icon(Icons.delete)),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Material: ${revisionMaterialesList[i].material.descripcion}'),
                                    Text('Unidad: ${revisionMaterialesList[i].material.unidad}'),
                                    Text('Cantidad: ${revisionMaterialesList[i].cantidad}'),
                                    Text('Lote: ${revisionMaterialesList[i].lote}'),
                                    Text('Metodo de aplicacion: ${revisionMaterialesList[i].metodoAplicacion}'),
                                    Text('Ubicación: ${revisionMaterialesList[i].ubicacion}'),
                                    Text('Área de Cobertura: ${revisionMaterialesList[i].areaCobertura}'),
                                    Text('Plagas: ${revisionMaterialesList[i].plagas}'),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(
                            thickness: 2,
                            color: Colors.green,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Future<void> borrarMaterial(BuildContext context, RevisionMaterial material) async{
    bool isConnected = await _checkConnectivity();
    if(isConnected){
      RevisionMaterial materialABorrar = revision.revisionMaterial.firstWhere((element) => element.otMaterialId == material.otMaterialId);
      await MaterialesServices().deleteRevisionMaterialOffline(materialABorrar, orden);
      await MaterialesServices().deleteRevisionMaterial(context,orden,material,token);
    }else{
      if(material.otMaterialId == 0) {
        pendientesBox.delete(material.hiveKey);
      } else {
        Pendiente pendienteABorrar = Pendiente.empty();
        pendienteABorrar.accion = 3;
        pendienteABorrar.objeto = material;
        pendienteABorrar.ordenId = orden.ordenTrabajoId;
        pendienteABorrar.otRevisionId = orden.otRevisionId;
        pendienteABorrar.tipo = 7;
        int hiveKeySelected = await addToBoxPendientes(pendienteABorrar);
        Pendiente objetoPendienteSeleccionado = pendientesBox.get(hiveKeySelected);
        objetoPendienteSeleccionado.objeto.hiveKey = hiveKeySelected;
      }
      await MaterialesServices().deleteRevisionMaterialOffline(material, orden);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('El Material ${material.material} ha sido borrado'),
        )
      );  
      router.pop(context);
    }
    // revisionMaterialesList.removeAt(i);
    setState(() {});
  }

  Future<void> posteoRevisionMateriales(Materiales material, BuildContext context) async {
    late List<int> plagasIds = [];
    bool isConnected = await _checkConnectivity();
    Revision revisionSeleccionada = revisiones.values.where((revision) => revision.otRevisionId == orden.otRevisionId).toList()[0];
    late Pendiente pendiente = Pendiente.empty();
    final RevisionMaterial nuevaRevisionMaterial =
      RevisionMaterial(
        otMaterialId: 0,
        ordenTrabajoId: orden.ordenTrabajoId,
        otRevisionId: orden.otRevisionId,
        cantidad: esNumerico(cantidad) ? double.parse(cantidad) : double.parse("0.0"),
        comentario: '',
        ubicacion: ubicacion,
        areaCobertura: areaCobertura,
        plagas: plagasSeleccionadas,
        material: material,
        lote: selectedLote!,
        metodoAplicacion: selectedMetodo!,
        hiveKey: 0
      );
    for (var i = 0; i < plagasSeleccionadas.length; i++) {
      plagasIds.add(plagasSeleccionadas[i].plagaId);
    }
    pendiente.objeto = nuevaRevisionMaterial;
    pendiente.accion = 1;
    pendiente.ordenId = orden.ordenTrabajoId;
    pendiente.otRevisionId = orden.otRevisionId;
    pendiente.tipo = 5;


    if(isConnected){
      revisionSeleccionada.revisionMaterial.add(nuevaRevisionMaterial);
      await MaterialesServices().postRevisionMaterial(context, orden, plagasIds, nuevaRevisionMaterial, token);
      // revisionMaterialesList.add(nuevaRevisionMaterial);
      MaterialesServices.showDialogs(context, 'Material Guardado', false, false);
    }
    else{
      revisionSeleccionada.revisionMaterial.add(nuevaRevisionMaterial);
      int hiveKeySelected = await addToBoxPendientes(pendiente);
      Pendiente objetoPendienteSeleccionado = pendientesBox.get(hiveKeySelected);
      objetoPendienteSeleccionado.objeto.hiveKey = hiveKeySelected;
    }
    setState(() {});
  }

  bool esNumerico(String str) {
    return double.tryParse(str) != null;
  }

}
