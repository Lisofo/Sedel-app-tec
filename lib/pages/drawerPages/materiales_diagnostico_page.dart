// ignore_for_file: use_build_context_synchronously, avoid_init_to_null, void_checks

import 'package:app_tecnicos_sedel_wifiless/models/material.dart';
import 'package:app_tecnicos_sedel_wifiless/models/orden.dart';
import 'package:app_tecnicos_sedel_wifiless/models/plaga.dart';
import 'package:app_tecnicos_sedel_wifiless/models/revision_materiales.dart';
import 'package:app_tecnicos_sedel_wifiless/providers/orden_provider.dart';
import 'package:app_tecnicos_sedel_wifiless/services/materiales_diagnostico_services.dart';
import 'package:app_tecnicos_sedel_wifiless/services/plagas_services.dart';
import 'package:app_tecnicos_sedel_wifiless/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/lote.dart';
import '../../models/metodo_aplicacion.dart';

class MaterialesDiagnosticoPage extends StatefulWidget {
  const MaterialesDiagnosticoPage({super.key});

  @override
  State<MaterialesDiagnosticoPage> createState() => _MaterialesDiagnosticoPageState();
}

class _MaterialesDiagnosticoPageState extends State<MaterialesDiagnosticoPage> {
  late List<String> savedData = [];
  List<Materiales> materiales = [];
  List<MetodoAplicacion> metodosAplicacion = [];
  late List<Lote> lotes = [];
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
  final TextEditingController comentarioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cargarDatos();
  }

  cargarDatos() async {
    token = context.read<OrdenProvider>().token;
    orden = context.read<OrdenProvider>().orden;
    marcaId = context.read<OrdenProvider>().marcaId;
    materiales = await MaterialesDiagnosticoServices().getMateriales(token);
    revisionMaterialesList = await MaterialesDiagnosticoServices().getRevisionMateriales(orden, token);
    setState(() {});
  }

  void _showMaterialDetails(BuildContext context, Materiales material) async {
    plagas = await PlagaServices().getPlagas(token);
    lotes = await MaterialesDiagnosticoServices().getLotes(selectedMaterial.materialId, token);
    metodosAplicacion = await MaterialesDiagnosticoServices().getMetodosAplicacion(token);
    selectedMetodo = MetodoAplicacion.empty();
    selectedLote = Lote.empty();
    comentarioController.text = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
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
              CustomTextFormField(
                label: 'Cantidad',
                keyboard: TextInputType.number,
                onChanged: (value) {
                  cantidad = value;
                },
              ),
              const SizedBox(height: 16,),
              CustomTextFormField(
                controller: comentarioController,
                maxLines: 1,
                label: 'Comentario',
              )
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
                final RevisionMaterial nuevaRevisionMaterial =
                    RevisionMaterial(
                        otMaterialId: 0,
                        ordenTrabajoId: orden.ordenTrabajoId,
                        otRevisionId: orden.otRevisionId,
                        cantidad: esNumerico(cantidad) ? double.parse(cantidad) : double.parse("0.0"),
                        comentario: comentarioController.text,
                        ubicacion: '',
                        areaCobertura: '',
                        plagas: [],
                        material: material,
                        lote: Lote.empty(),
                        metodoAplicacion: MetodoAplicacion.empty());
                await MaterialesDiagnosticoServices().postRevisionMaterial(
                    context, orden, nuevaRevisionMaterial, token);
                revisionMaterialesList.add(nuevaRevisionMaterial);
        
                setState(() {});
              },
            ),
          ],
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
              const SizedBox(
                height: 20,
              ),
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
                          final item = revisionMaterialesList[i];
                          return Dismissible(
                            key: Key(item.toString()),
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
                                    content: const Text(
                                        "¿Estas seguro de querer borrar el material?"),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context)
                                                .pop(false),
                                        child: const Text("CANCELAR"),
                                      ),
                                      TextButton(
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.red,
                                          ),
                                          onPressed: () async {
                                            Navigator.of(context).pop(true);
                                            await MaterialesDiagnosticoServices().deleteRevisionMaterial(context, orden,revisionMaterialesList[i],token);
                                          },
                                          child: const Text("BORRAR")),
                                    ],
                                  );
                                },
                              );
                            },
                            onDismissed: (direction) {
                              setState(() {
                                revisionMaterialesList.removeAt(i);
                              });
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('$item borrado'),
                              ));
                            },
                            background: Container(
                              color: Colors.red,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20),
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
                                              title:
                                                  const Text("Confirmar"),
                                              content: const Text(
                                                  "¿Estas seguro de querer borrar el material?"),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(false),
                                                  child: const Text(
                                                      "CANCELAR"),
                                                ),
                                                TextButton(
                                                    style: TextButton.styleFrom(
                                                      foregroundColor:
                                                          Colors.red,
                                                    ),
                                                    onPressed: () async {
                                                      await borrarMaterial(context, item, i);
                                                    },
                                                    child: const Text(
                                                        "BORRAR")),
                                              ],
                                            );
                                          });
                                    },
                                    icon: const Icon(Icons.delete)),
                                title: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'Material: ${revisionMaterialesList[i].material.descripcion}'),
                                    Text(
                                        'Unidad: ${revisionMaterialesList[i].material.unidad}'),
                                    Text(
                                        'Cantidad: ${revisionMaterialesList[i].cantidad}'),
                                    Text(
                                        'Comentario: ${revisionMaterialesList[i].comentario}'),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder:
                            (BuildContext context, int index) {
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

  Future<void> borrarMaterial(BuildContext context, RevisionMaterial item, int i) async {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
      content: Text('$item borrado'),
    ));
    await MaterialesDiagnosticoServices().deleteRevisionMaterial(context, orden, revisionMaterialesList[i], token);
    setState(() {
      revisionMaterialesList.removeAt(i);
    });
  }

  bool esNumerico(String str) {
    return double.tryParse(str) != null;
  }
}
