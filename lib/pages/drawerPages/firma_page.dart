// ignore_for_file: use_build_context_synchronously, avoid_print, unused_local_variable, unrelated_type_equality_checks

import 'dart:typed_data';

import 'package:app_tecnicos_sedel_wifiless/offline/box_func.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';
import 'package:crypto/crypto.dart';

import '../../config/router/router.dart';
import '../../models/clientes_firmas.dart';
import '../../models/orden.dart';
import '../../models/pendiente.dart';
import '../../models/revision.dart';
import '../../offline/boxes.dart';
import '../../providers/orden_provider.dart';
import '../../services/revision_services.dart';
import '../../widgets/custom_button.dart';

class Firma extends StatefulWidget {
  const Firma({super.key});

  @override
  State<Firma> createState() => _FirmaState();
}

class _FirmaState extends State<Firma> {
  final _formKey1 = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  List<ClienteFirma> client = [];
  late int marcaId = 0;
  bool isReadOnly = true;
  late Orden orden = Orden.empty();
  late String token = '';
  Uint8List? exportedImage;
  late String md5Hash = '';
  late List<int> firmaBytes = [];
  late Revision revision = Revision.empty();
  SignatureController controller = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.transparent,
  );

  @override
  void initState() {
    super.initState();
    cargarDatos();
  }

  cargarDatos() async {
    token = context.read<OrdenProvider>().token;
    orden = context.read<OrdenProvider>().orden;
    marcaId = context.read<OrdenProvider>().marcaId;
    client = await RevisionServices().getRevisionFirmas(orden, token);
    revision = revisiones.values.where((revision) => revision.otRevisionId == orden.otRevisionId).toList()[0];
    if (orden.estado == "EN PROCESO" && marcaId != 0) {
      isReadOnly = false;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          backgroundColor: colors.primary,
          title: Text(
            '${orden.ordenTrabajoId} - Firma',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Form(
                        key: _formKey1,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: colors.primary,
                                      width: 2),
                                  borderRadius: BorderRadius.circular(5)),
                              child: TextFormField(
                                controller: nameController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(5)),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: 'Nombre'),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: colors.primary,
                                      width: 2),
                                  borderRadius: BorderRadius.circular(5)),
                              child: TextFormField(
                                controller: areaController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(5)),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: 'Area'),
                              ),
                            )
                          ],
                        )),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: colors.primary,
                              width: 2),
                          borderRadius: BorderRadius.circular(5)),
                      child: Signature(
                          controller: controller,
                          width: 350,
                          height: 200,
                          backgroundColor: Colors.white),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: CustomButton(
                          onPressed: () async {
                            if (nameController.text.isNotEmpty && areaController.text.isNotEmpty) {
                              await guardarFirma(context, null);
                            } else {
                              completeDatosPopUp(context);
                            }
                          },
                          text: 'Guardar',
                          tamano: 20,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton(
                            onPressed: () {
                              controller.clear();
                            },
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.white),
                                elevation: MaterialStatePropertyAll(10),
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(50),
                                            right: Radius.circular(50))))),
                            child: Icon(
                              Icons.delete,
                              color: colors.primary,
                            )),
                      )
                    ],
                  ),
                  // if (exportedImage != null) Image.memory(exportedImage!),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      itemCount: client.length,
                      itemBuilder: (context, index) {
                        final item = client[index];
                        return Dismissible(
                          key: Key(item.toString()),
                          direction: DismissDirection.endToStart,
                          confirmDismiss: (DismissDirection direction) {
                            return showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return borrarDesdeDismiss(context, item);
                              }
                            );
                          },
                          onDismissed: (direction) async {
                            setState(() {
                              client.removeAt(index);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                Text('La firma de $item ha sido borrada'),
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
                            decoration: const BoxDecoration(
                                border: Border(bottom: BorderSide())),
                            child: ListTile(
                              tileColor: Colors.white,
                              title: Text(item.nombre),
                              subtitle: Text(item.area),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    splashColor: Colors.transparent,
                                    splashRadius: 25,
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      _editarCliente(item);
                                    },
                                  ),
                                  IconButton(
                                    splashColor: Colors.transparent,
                                    splashRadius: 25,
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      _borrarCliente(item);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            if (isReadOnly)
              IgnorePointer(
                ignoring: false,
                child: Container(
                  color: Colors.grey.withOpacity(0.6),
                ),
              ),
          ],
        ),
      ),
    );
  }

  AlertDialog borrarDesdeDismiss(BuildContext context, ClienteFirma client) {
    return AlertDialog(
      surfaceTintColor: Colors.white,
      title: const Text("Confirmar"),
      content: const Text("¿Estas seguro de querer borrar la firma?"),
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
            bool isConnected = await _checkConnectivity();
              if(isConnected){
                ClienteFirma firmaABorrar = revision.revisionFirma.firstWhere((element) => element.otFirmaId == client.otFirmaId);
                await RevisionServices().deleteRevisionFirmaOffline( orden, firmaABorrar);
                await RevisionServices().deleteRevisionFirma(context, orden, client, token);
              }else{
                if(client.otFirmaId == 0){
                  Pendiente pendienteABorrar = Pendiente.empty();
                  pendienteABorrar.accion = 3;
                  pendienteABorrar.objeto = client;
                  pendienteABorrar.ordenId = orden.ordenTrabajoId;
                  pendienteABorrar.otRevisionId = orden.otRevisionId;
                  pendienteABorrar.tipo = 3;
                  int hiveKeySelected = await addToBoxPendientes(pendienteABorrar);
                  Pendiente objetoPendienteSeleccionado = pendientesBox.get(hiveKeySelected);
                  objetoPendienteSeleccionado.objeto.hiveKey = hiveKeySelected;
                }
                await RevisionServices().deleteRevisionFirmaOffline( orden, client);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('La firma de ${client.nombre} ha sido borrada'),
                  )
                );  
              }
              // client.removeAt(i);
            router.pop(context); 
          },
          child: const Text("BORRAR")
          ),
      ],
    );
  }

  Future<void> guardarFirma(BuildContext context, Uint8List? firma) async {
    exportedImage = firma ?? await controller.toPngBytes();
    firmaBytes = exportedImage as List<int>;
    md5Hash = calculateMD5(firmaBytes);
    int? statusCode;
    bool isConnected = await _checkConnectivity();
    RevisionServices revisionServices = RevisionServices();
    Revision revisionSeleccionada = revisiones.values.where((revision) => revision.otRevisionId == orden.otRevisionId).toList()[0];
    late Pendiente pendiente = Pendiente.empty();

    final ClienteFirma nuevaFirma = ClienteFirma(
      otFirmaId: 0,
      ordenTrabajoId: orden.ordenTrabajoId,
      otRevisionId: orden.otRevisionId,
      nombre: nameController.text,
      area: areaController.text,
      firmaPath: '',
      firmaMd5: md5Hash,
      comentario: '',
      firma: exportedImage,
      hiveKey: 0,
    );
    pendiente.objeto = nuevaFirma;
    pendiente.accion = 1;
    pendiente.ordenId = orden.ordenTrabajoId;
    pendiente.otRevisionId = orden.otRevisionId;
    pendiente.tipo = 3;

    if (isConnected) {
      revisionSeleccionada.revisionFirma.add(nuevaFirma);
      await revisionServices.postRevisonFirma(context, orden, nuevaFirma, token);
      statusCode = await revisionServices.getStatusCodeFirma();

      if(statusCode == 201){
        _agregarCliente();
      }else{
        print('error');
      }  
    } else {
      revisionSeleccionada.revisionFirma.add(nuevaFirma);
      int hiveKeySelected = await addToBoxPendientes(pendiente);
      Pendiente objetoPendienteSeleccionado = pendientesBox.get(hiveKeySelected);
      objetoPendienteSeleccionado.objeto.hiveKey = hiveKeySelected;
      _agregarCliente();
      RevisionServices.showDialogs(context, 'Firma guardada', false, false);
    }
  }

  void completeDatosPopUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          surfaceTintColor: Colors.white,
          title: const Text('Campos vacíos'),
          content: const Text(
            'Por favor, completa todos los campos antes de guardar.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  String calculateMD5(List<int> bytes) {
    var md5c = md5.convert(bytes);
    return md5c.toString();
  }
  
  Future<bool> _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  void _agregarCliente() {
    if (_formKey1.currentState!.validate()) {
      setState(() {
        client.add(ClienteFirma(
          nombre: nameController.text,
          area: areaController.text,
          firma: exportedImage,
          otFirmaId: 0,
          firmaPath: '',
          ordenTrabajoId: 0,
          otRevisionId: 0,
          firmaMd5: '',
          comentario: '',
          hiveKey: 0,
        ));

        nameController.clear();
        areaController.clear();
        controller.clear();
        exportedImage = null;
      });
    }
  }

  Future<void> _borrarCliente(ClienteFirma clienteFirma) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: Colors.white,
          title: const Text("Confirmar"),
          content: const Text("¿Estas seguro de querer borrar la firma?"),
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
                bool isConnected = await _checkConnectivity();
                if(isConnected){
                  ClienteFirma firmaABorrar = revision.revisionFirma.firstWhere((element) => element.otFirmaId == clienteFirma.otFirmaId);
                  await RevisionServices().deleteRevisionFirmaOffline( orden, firmaABorrar);
                  await RevisionServices().deleteRevisionFirma(context, orden, clienteFirma, token);
                }else{
                  if(clienteFirma.otFirmaId == 0){
                    Pendiente pendienteABorrar = Pendiente.empty();
                    pendienteABorrar.accion = 3;
                    pendienteABorrar.objeto = clienteFirma;
                    pendienteABorrar.ordenId = orden.ordenTrabajoId;
                    pendienteABorrar.otRevisionId = orden.otRevisionId;
                    pendienteABorrar.tipo = 3;
                    int hiveKeySelected = await addToBoxPendientes(pendienteABorrar);
                    Pendiente objetoPendienteSeleccionado = pendientesBox.get(hiveKeySelected);
                    objetoPendienteSeleccionado.objeto.hiveKey = hiveKeySelected;
                  }
                  await RevisionServices().deleteRevisionFirmaOffline( orden, clienteFirma);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('La firma de ${clienteFirma.nombre} ha sido borrada'),
                    )
                  );  
                }
                // client.removeAt(i);
                router.pop(context); 
                setState(() {});
              },
              child: const Text("BORRAR")
            ),
          ],
        );
      }
    );
  }

  void _editarCliente(ClienteFirma firma) async {
    String nuevoNombre = firma.nombre;
    String nuevoArea = firma.area;
    bool isConnected = await _checkConnectivity();
    Revision revisionSeleccionada = revisiones.values.where((revision) => revision.otRevisionId == orden.otRevisionId).toList()[0];
    Pendiente objetoPendienteSeleccionado = Pendiente.empty();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          surfaceTintColor: Colors.white,
          title: const Text('Editar Cliente'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: TextEditingController(text: nuevoNombre),
                onChanged: (value) {
                  nuevoNombre = value;
                },
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: TextEditingController(text: nuevoArea),
                onChanged: (value) {
                  nuevoArea = value;
                },
                decoration: const InputDecoration(labelText: 'Área'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                firma.area = nuevoArea;
                firma.nombre = nuevoNombre;
                late Pendiente pendiente = Pendiente.empty();
                pendiente.objeto = firma;
                pendiente.accion = 2;
                pendiente.ordenId = orden.ordenTrabajoId;
                pendiente.otRevisionId = orden.otRevisionId;
                pendiente.tipo = 3;
                if(isConnected){
                  await RevisionServices().putRevisionFirma(context, orden, firma, token);
                } else {
                  if(firma.otFirmaId == 0){
                    if(firma.hiveKey == 0){
                      int hiveKeySelected = await addToBoxPendientes(pendiente);
                      objetoPendienteSeleccionado = pendientesBox.get(hiveKeySelected);
                      objetoPendienteSeleccionado.objeto.hiveKey = hiveKeySelected;
                    } else {
                      objetoPendienteSeleccionado = pendientesBox.get(firma.hiveKey);
                      objetoPendienteSeleccionado.objeto.area = nuevoArea;
                      objetoPendienteSeleccionado.objeto.nombre = nuevoNombre;
                    }
                  } else{
                    objetoPendienteSeleccionado = pendiente;
                    objetoPendienteSeleccionado.objeto.area = nuevoArea;
                    objetoPendienteSeleccionado.objeto.nombre = nuevoNombre;
                    await addToBoxPendientes(objetoPendienteSeleccionado);
                  }
                  revisionSeleccionada.revisionFirma.add(firma);
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    ).then((result) {
      if (result != null &&
          result['nombre'] != null &&
          result['area'] != null) {
        setState(() {
          firma.nombre = result['nombre'];
          firma.area = result['area'];
        });
      }
    });
  }
}
