// ignore_for_file: file_names, use_build_context_synchronously, avoid_print, void_checks, unrelated_type_equality_checks

import 'package:app_tecnicos_sedel_wifiless/models/orden.dart';
import 'package:app_tecnicos_sedel_wifiless/models/plaga_objetivo.dart';
import 'package:app_tecnicos_sedel_wifiless/models/revision_pto_inspeccion.dart';
import 'package:app_tecnicos_sedel_wifiless/models/tipos_ptos_inspeccion.dart';
import 'package:app_tecnicos_sedel_wifiless/models/zona.dart';
import 'package:app_tecnicos_sedel_wifiless/services/plagas_services.dart';
import 'package:app_tecnicos_sedel_wifiless/services/ptos_services.dart';
import 'package:app_tecnicos_sedel_wifiless/widgets/custom_form_dropdown.dart';
import 'package:app_tecnicos_sedel_wifiless/widgets/custom_form_field.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:app_tecnicos_sedel_wifiless/config/router/router.dart';
import 'package:app_tecnicos_sedel_wifiless/models/bottomSheets_opciones.dart';
import 'package:app_tecnicos_sedel_wifiless/providers/orden_provider.dart';

import '../../../models/revision.dart';
import '../../../offline/box_func.dart';
import '../../../offline/boxes.dart';

class PtosInspeccionPage extends StatefulWidget {
  const PtosInspeccionPage({super.key});

  @override
  State<PtosInspeccionPage> createState() => _PtosInspeccionPageState();
}

class _PtosInspeccionPageState extends State<PtosInspeccionPage> {
  List<TipoPtosInspeccion> tiposDePuntos = [];
  List<RevisionPtoInspeccion> ptosInspeccion = [];
  late TipoPtosInspeccion selectedTipoPto = TipoPtosInspeccion.empty();
  List<RevisionPtoInspeccion> selectedPuntosDeInspeccion = [];
  late List<PlagaObjetivo>  plagasObjetivo = [];
  late TextEditingController comentarioController = TextEditingController();
  late TextEditingController sectorController = TextEditingController();
  late TextEditingController codPuntoInspeccionController = TextEditingController();
  late TextEditingController codigoBarraController = TextEditingController();
  late ZonaPI zonaSeleccionada = ZonaPI.empty();
  late PlagaObjetivo plagaObjetivoSeleccionada = PlagaObjetivo.empty();
  bool selectAll = false;
  bool filtro = false;
  late String token = '';
  late Orden orden = Orden.empty();
  late int marcaId = 0;
  bool pendientes = false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  late Revision revision = Revision.empty();

  readQRCode() async {
    String code = await FlutterBarcodeScanner.scanBarcode('#FFFFFF', 'Cancelar', false, ScanMode.QR);
    /*context.read<ItemProvider>().setItem(code);
    var products = widget.products;
    final prodPP =
        products.firstWhere((element) => element.codItem == code, orElse: () {
      return Product.empty();
    });
    context.read<ItemProvider>().setProduct(prodPP);*/
    if (code == '') {
      return null;
    } else {
      _mostrarBottomSheet();
    }
  }

  List<ZonaPI> zonas = [
    ZonaPI(zona: 'Interior', codZona: 'I'),
    ZonaPI(zona: 'Exterior', codZona: 'E'),
  ];

  List<RevisionPtoInspeccion> get ptosFiltrados {
    return ptosInspeccion
        .where((pto) =>
            pto.tipoPuntoInspeccionId == selectedTipoPto.tipoPuntoInspeccionId)
        .toList();
  }

  List<RevisionPtoInspeccion> get puntosSeleccionados {
    return ptosFiltrados.where((pto) => pto.seleccionado).toList();
  }

  int get seleccionados {
    return puntosSeleccionados.length;
  }

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
      tiposDePuntos = await PtosInspeccionServices().getTiposPtosInspeccion(token);
      ptosInspeccion = await PtosInspeccionServices().getPtosInspeccion(context, orden, token);
      plagasObjetivo = await PlagaServices().getPlagasObjetivo(context, token);
      Provider.of<OrdenProvider>(context, listen: false).setTipoPTI(selectedTipoPto);
      if(codigueras.values.whereType<PlagaObjetivo>().toList().isEmpty){
        for(int i = 0; i<plagasObjetivo.length; i++){
          addListasToBoxCodiguera(null, null, null, null, null, plagasObjetivo[i], null);
        }
      }
      if(codigueras.values.whereType<TipoPtosInspeccion>().toList().isEmpty){
        for(int i = 0; i<tiposDePuntos.length; i++){
          addListasToBoxCodiguera(null, null, null, null, null, null, tiposDePuntos[i]);
        }
      }
      revision.revisionPtoInspeccion = ptosInspeccion;
    }else{
      plagasObjetivo = await PlagaServices().getPlagasObjetivoOffline();
      tiposDePuntos = await PtosInspeccionServices().getTiposPtosInspeccionOffline();
      ptosInspeccion = revision.revisionPtoInspeccion;
    }

    setState(() {});
  }

  Future<void> refreshData() async {
    bool isConnected = await _checkConnectivity();
    if(isConnected){
      ptosInspeccion = await PtosInspeccionServices().getPtosInspeccion(context, orden, token);
      setState(() {});
    }else{}
    
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '${orden.ordenTrabajoId} - Ptos de Inspeccion',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 52, 120, 62),
          actions: [
            IconButton(
              onPressed: readQRCode,
              icon: const Icon(Icons.qr_code_scanner_rounded),
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
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
                child: DropdownButtonFormField(
                  decoration:
                      const InputDecoration(border: InputBorder.none),
                  hint: const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text('Ptos de Inspeccion'),
                  ),
                  items: tiposDePuntos.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          e.descripcion,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  }).toList(),
                  isDense: true,
                  isExpanded: true,
                  onChanged: (value) {
                    setState(() {
                      Provider.of<OrdenProvider>(context, listen: false).setTipoPTI(value!);
                      selectedTipoPto = value;
                      selectAll = false;
                      for (var i = 0; i < ptosFiltrados.length; i++) {
                        ptosFiltrados[i].seleccionado = false;
                      }
                    });
                  },
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  key: _refreshIndicatorKey,
                  onRefresh: refreshData,
                  child: listaDePuntos()
                )
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if (selectedTipoPto.tipoPuntoInspeccionId != 0) {
                        if (marcaId == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Marque entrada antes de ingresar datos.'),
                          ));
                        } else {
                          _mostrarBottomSheet();
                        }
                      }
                    },
                    icon: Icon(
                      Icons.control_point,
                      size: 35,
                      color: selectedTipoPto.tipoPuntoInspeccionId != 0
                          ? const Color.fromARGB(255, 52, 120, 62)
                          : Colors.grey,
                    ),
                  ),
                  Switch(
                      activeColor: const Color.fromARGB(255, 52, 120, 62),
                      value: filtro,
                      onChanged: (value) {
                        setState(() {
                          filtro = value;
                          pendientes = filtro;
                          Provider.of<OrdenProvider>(context, listen: false).setPendiente(pendientes);
                          selectAll = false;
                          for (var i = 0; i < ptosFiltrados.length; i++) {
                            ptosFiltrados[i].seleccionado = false;
                          }
                          listaDePuntos();
                        });
                      }),
                  const Spacer(),
                  Checkbox(
                    activeColor: const Color.fromARGB(255, 52, 120, 62),
                    value: selectAll,
                    onChanged: (newValue) {
                      setState(() {
                        selectAll = newValue!;
                        for (var ptos
                            in context.read<OrdenProvider>().listaPuntos) {
                          ptos.seleccionado = selectAll;
                        }
                      });
                    },
                  ),
                  IconButton(
                    onPressed: () async {
                      if(marcaId == 0){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Marque entrada antes de ingresar datos.'),
                        ));
                        return Future.value(false);
                      }
                      borrarAccion();
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    )
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  listaDePuntos() {
    return Consumer<OrdenProvider>(builder: (context, provider, child) {
      return ListView.builder(
        itemCount: provider.listaPuntos.length,
        itemBuilder: (context, index) {
          final puntoDeInspeccion = provider.listaPuntos[index];
          return ListTile(
            title: Row(
              children: [
                Text('Punto ${puntoDeInspeccion.codPuntoInspeccion}'),
                const Spacer(),
                Text(
                  puntoDeInspeccion.codAccion.toString(),
                  style: const TextStyle(color: Color.fromARGB(255, 52, 120, 62)),
                )
              ],
            ),
            subtitle: Row(
              children: [
                Text('Zona: ${puntoDeInspeccion.zona}'),
                const SizedBox(width: 20,),
                Text('Sector: ${puntoDeInspeccion.sector}'),
              ],
            ),
            trailing: Checkbox(
              activeColor: const Color.fromARGB(255, 52, 120, 62),
              value: puntoDeInspeccion.seleccionado,
              splashRadius: 40,
              onChanged: (bool? newValue) {
                setState(() {
                  puntoDeInspeccion.seleccionado = newValue ?? false;
                });
              },
            ),
            onTap: () {
              if (puntoDeInspeccion.seleccionado) {
                // Provider.of<OrdenProvider>(context, listen: false).setPI(puntosSeleccionados);
              } else {
                Provider.of<OrdenProvider>(context, listen: false).setRevisionPI(puntoDeInspeccion);
              }
              router.push('/ptosInspeccionRevision');
            },
          );
        },
      );
    });
  }

  void _mostrarBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        List<BottomSheetOpcion> listaOpciones = [
          BottomSheetOpcion(
            text: 'Sin Actividad',
            icon: Icons.cancel,
            ruta: 'Sin Actividad',
            condicion: 'M'
          ),
          BottomSheetOpcion(
            text: 'Actividad',
            icon: Icons.check,
            ruta: '/ptosInspeccionActividad',
            condicion: 'M'
          ),
          BottomSheetOpcion(
            text: 'Mantenimiento',
            icon: Icons.build,
            ruta: '/ptosInspeccionActividad',
            condicion: 'M'
          ),
          BottomSheetOpcion(
            text: 'Desinstalado',
            icon: Icons.delete,
            ruta: 'Desinstalado',
            condicion: 'M'
          ),
          BottomSheetOpcion(
            text: 'Nuevo', 
            icon: Icons.add, 
            ruta: 'Nuevo', 
            condicion: 'S'
          ),
          BottomSheetOpcion(
            text: 'Trasladado',
            icon: Icons.swap_horiz,
            ruta: 'Trasladado',
            condicion: 'M'
          ),
          BottomSheetOpcion(
            text: 'Sin Acceso',
            icon: Icons.not_interested,
            ruta: 'Sin Acceso',
            condicion: 'M'
          ),
        ];
        {
          final List<BottomSheetOpcion> listaOpcionesAplicar = [];
          List<RevisionPtoInspeccion> elementosEncontrados = puntosSeleccionados.where((elemento) => elemento.piAccionId == 5).toList();
          for (var pto in listaOpciones) {
            if (seleccionados == 0 || (seleccionados == 1 && puntosSeleccionados[0].piAccionId == 5)) {
              if (pto.condicion == 'S') {
                listaOpcionesAplicar.add(pto);
              }
            } else if (pto.condicion == 'M' && seleccionados > 0 && elementosEncontrados.isEmpty) {
              listaOpcionesAplicar.add(pto);
            }
          }

          return listaOpcionesAplicar.isEmpty
              ? const Center(
                  child: Text(
                  'No hay opciones disponibles',
                  style: TextStyle(fontSize: 16),
                  )
                )
              : ListView.separated(
                  itemCount: listaOpcionesAplicar.length,
                  itemBuilder: (context, i) {
                    Color iconColor = listaOpcionesAplicar[i].text == 'Sin Acceso' ? Colors.red : Colors.green;
                    return ListTile(
                      onTap: () {
                        opciones(listaOpcionesAplicar, i, context);
                      },
                      leading: Icon(
                        listaOpcionesAplicar[i].icon,
                        color: iconColor,
                      ),
                      title: Text(listaOpcionesAplicar[i].text),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      height: 1,
                      color: Colors.green,
                    );
                  },
                );
        }
      },
    );
  }

  void opciones(List<BottomSheetOpcion> buttonTexts, int i, BuildContext context) {
    BottomSheetOpcion botones = buttonTexts[i];
    switch (botones.text) {
      case 'Mantenimiento':
      case 'Actividad':
        Provider.of<OrdenProvider>(context, listen: false).setPage(botones.text);
        Provider.of<OrdenProvider>(context, listen: false).setTipoPTI(selectedTipoPto);
        // Provider.of<OrdenProvider>(context, listen: false).setPI(puntosSeleccionados);
        if (botones.text == 'Mantenimiento') {
          Provider.of<OrdenProvider>(context, listen: false).SetModo('M');
        } else {
          Provider.of<OrdenProvider>(context, listen: false).SetModo('A');
        }
        router.push(botones.ruta);
        break;
      case 'Desinstalado':
      case 'Sin Actividad':
      case 'Sin Acceso':
        showDialog(
            context: context,
            builder: (context) {
              if (puntosSeleccionados.length == 1 &&
                      (puntosSeleccionados[0].piAccionId == 1 &&
                          botones.text == 'Sin Actividad') ||
                  (puntosSeleccionados[0].piAccionId == 4 &&
                      botones.text == 'Desinstalado') ||
                  puntosSeleccionados[0].piAccionId == 7 &&
                      botones.text == 'Sin Acceso') {
                comentarioController.text = puntosSeleccionados[0].comentario;
              } else {
                comentarioController.text = '';
              }
              return AlertDialog(
                title: Text(botones.text),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: comentarioController,
                      minLines: 1,
                      maxLines: 10,
                      decoration: const InputDecoration(hintText: 'Comentario'),
                    )
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Cancelar'),
                    onPressed: () {
                      router.pop(context);
                    },
                  ),
                  TextButton(
                    child: const Text('Confirmar'),
                    onPressed: () {
                      router.pop(context);
                      if (botones.text == 'Sin Actividad') {
                        marcarPISinActividad(1, comentarioController.text);
                      } else if (botones.text == 'Desinstalado') {
                        marcarPISinActividad(4, comentarioController.text);
                      } else {
                        marcarPISinActividad(7, comentarioController.text);
                      }
                    },
                  ),
                ],
              );
            });
        break;
      case 'Nuevo':
        showDialog(
            context: context,
            builder: (context) {
              if (puntosSeleccionados.length == 1 &&
                  puntosSeleccionados[0].piAccionId == 5) {
                codigoBarraController.text = puntosSeleccionados[0].codigoBarra;
                sectorController.text = puntosSeleccionados[0].sector;
                comentarioController.text = puntosSeleccionados[0].comentario;
                codPuntoInspeccionController.text =
                    puntosSeleccionados[0].codPuntoInspeccion;
                zonaSeleccionada = zonas.firstWhere((element) =>
                    element.codZona ==
                    puntosSeleccionados[0].trasladoNuevo[0].zona);
                plagaObjetivoSeleccionada = plagasObjetivo.firstWhere(
                    (element) => element.plagaObjetivoId == puntosSeleccionados[0].trasladoNuevo[0].plagaObjetivoId);
              } else {
                codigoBarraController.text = '';
                sectorController.text = '';
                comentarioController.text = '';
                codPuntoInspeccionController.text = '';
                plagaObjetivoSeleccionada = PlagaObjetivo.empty();
                zonaSeleccionada = ZonaPI.empty();
              }

              return SingleChildScrollView(
                child: AlertDialog(
                  title: const Text('Nuevo Punto'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextFormField(
                        controller: codPuntoInspeccionController,
                        maxLines: 1,
                        hint: 'Codigo punto de inspeccion',
                        label: 'Codigo punto de inspeccion',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomDropdownFormMenu(
                          hint: 'Zona',
                          value: zonaSeleccionada.codZona != ''
                              ? zonaSeleccionada
                              : null,
                          items: zonas.map((e) {
                            return DropdownMenuItem(
                              value: e,
                              child: Text(
                                e.zona,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            zonaSeleccionada = value;
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        controller: sectorController,
                        maxLines: 1,
                        hint: 'Sector',
                        label: "Sector",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomDropdownFormMenu(
                          hint: 'Plaga objetivo',
                          value: plagaObjetivoSeleccionada.plagaObjetivoId != 0
                              ? plagaObjetivoSeleccionada
                              : null,
                          items: plagasObjetivo.map((e) {
                            return DropdownMenuItem<PlagaObjetivo>(
                              value: e,
                              child: SizedBox(
                                width: 180,
                                child: Text(
                                  e.descripcion,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            plagaObjetivoSeleccionada = value;
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                          controller: comentarioController,
                          maxLines: 1,
                          hint: 'Comentario',
                          label: 'Comentario'),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        controller: codigoBarraController,
                        maxLines: 1,
                        hint: 'Codigo de barras',
                        label: 'Codigo de barras',
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Cancelar'),
                      onPressed: () {
                        router.pop(context);
                      },
                    ),
                    TextButton(
                      child: const Text('Confirmar'),
                      onPressed: () async {
                        router.pop(context);
                        await marcarPINuevo(5, zonaSeleccionada,
                            sectorController.text, comentarioController.text);
                      },
                    ),
                  ],
                ),
              );
            });
        break;
      case 'Trasladado':
        showDialog(
            context: context,
            builder: (context) {
              if (puntosSeleccionados[0].otPuntoInspeccionId != 0 && puntosSeleccionados[0].piAccionId == 6) {
                sectorController.text = puntosSeleccionados[0].trasladoNuevo[0].sector;
                comentarioController.text = puntosSeleccionados[0].comentario;
                zonaSeleccionada = zonas.firstWhere((element) => element.codZona == puntosSeleccionados[0].trasladoNuevo[0].zona);
              } else {
                sectorController.text = '';
                comentarioController.text = '';
                zonaSeleccionada = ZonaPI.empty();
              }
              return AlertDialog(
                title: Text(botones.text),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomDropdownFormMenu(
                      hint: 'Zona',
                      value: zonaSeleccionada.codZona != ''
                          ? zonaSeleccionada
                          : null,
                      items: zonas.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(
                            e.zona,
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        zonaSeleccionada = value;
                      }
                    ),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      controller: sectorController,
                      maxLines: 1,
                      hint: 'Sector',
                      label: 'Sector',
                    ),
                    const SizedBox(height: 10,),
                    CustomTextFormField(
                      controller: comentarioController,
                      maxLines: 1,
                      hint: 'Comentario',
                      label: 'Comentario',
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Cancelar'),
                    onPressed: () {
                      router.pop(context);
                    },
                  ),
                  TextButton(
                    child: const Text('Confirmar'),
                    onPressed: () async {
                      router.pop(context);
                      await marcarPITraslado(6, zonaSeleccionada, sectorController.text, comentarioController.text);
                    },
                  ),
                ],
              );
            });
        break;
    }
  }

  Future marcarPISinActividad(int idPIAccion, String comentario) async {
    for (var i = 0; i < puntosSeleccionados.length; i++) {
      RevisionPtoInspeccion nuevaRevisionPtoInspeccion = RevisionPtoInspeccion(
          otPuntoInspeccionId: puntosSeleccionados[i].otPuntoInspeccionId,
          ordenTrabajoId: orden.ordenTrabajoId,
          otRevisionId: orden.otRevisionId,
          puntoInspeccionId: puntosSeleccionados[i].puntoInspeccionId,
          planoId: puntosSeleccionados[i].planoId,
          tipoPuntoInspeccionId: puntosSeleccionados[i].tipoPuntoInspeccionId,
          codTipoPuntoInspeccion: puntosSeleccionados[i].codTipoPuntoInspeccion,
          descTipoPuntoInspeccion: '',
          plagaObjetivoId: puntosSeleccionados[i].plagaObjetivoId,
          codPuntoInspeccion: puntosSeleccionados[i].codPuntoInspeccion,
          codigoBarra: puntosSeleccionados[i].codigoBarra,
          zona: puntosSeleccionados[i].zona,
          sector: puntosSeleccionados[i].sector,
          idPIAccion: idPIAccion,
          piAccionId: 1,
          codAccion: '1',
          descPiAccion: '',
          comentario: comentario,
          materiales: [],
          plagas: [],
          tareas: [],
          trasladoNuevo: [],
          seleccionado: puntosSeleccionados[i].seleccionado);

      print(puntosSeleccionados[i].puntoInspeccionId);
      if (puntosSeleccionados[i].otPuntoInspeccionId != 0) {
        await PtosInspeccionServices().putPtoInspeccionAccion(context, orden, nuevaRevisionPtoInspeccion, token);
      } else {
        await PtosInspeccionServices().postPtoInspeccionAccion(context, orden, nuevaRevisionPtoInspeccion, token);
      }
    }

    await actualizarDatos();
    limpiarDatos();

    await PtosInspeccionServices.showDialogs(context, 'Punto guardado', true, false);
  }

  Future marcarPITraslado(int idPIAccion, ZonaPI zonaSeleccionada, String sector, String comentario) async {
    bool isConnected = await _checkConnectivity();
    for (int i = 0; i < puntosSeleccionados.length; i++) {
      RevisionPtoInspeccion nuevaRevisionPtoInspeccion = RevisionPtoInspeccion(
          otPuntoInspeccionId: puntosSeleccionados[i].otPuntoInspeccionId,
          ordenTrabajoId: orden.ordenTrabajoId,
          otRevisionId: orden.otRevisionId,
          puntoInspeccionId: puntosSeleccionados[i].puntoInspeccionId,
          planoId: puntosSeleccionados[i].planoId,
          tipoPuntoInspeccionId: selectedTipoPto.tipoPuntoInspeccionId,
          codTipoPuntoInspeccion: puntosSeleccionados[i].codTipoPuntoInspeccion,
          descTipoPuntoInspeccion: '',
          plagaObjetivoId: puntosSeleccionados[i].plagaObjetivoId,
          codPuntoInspeccion: puntosSeleccionados[i].codPuntoInspeccion != ''
              ? puntosSeleccionados[i].codPuntoInspeccion
              : codPuntoInspeccionController.text,
          codigoBarra: puntosSeleccionados[i].codigoBarra != ''
              ? puntosSeleccionados[i].codigoBarra
              : codigoBarraController.text,
          zona: zonaSeleccionada.codZona,
          sector: sector,
          idPIAccion: idPIAccion,
          piAccionId: 1,
          codAccion: '1',
          descPiAccion: '',
          comentario: comentario,
          materiales: [],
          plagas: [],
          tareas: [],
          trasladoNuevo: [],
          seleccionado: puntosSeleccionados[i].seleccionado);
      if(isConnected){
        if (puntosSeleccionados[i].otPuntoInspeccionId != 0) {
          await PtosInspeccionServices().putPtoInspeccionAccion(context, orden, nuevaRevisionPtoInspeccion, token);
        } else {
          revision.revisionPtoInspeccion.add(nuevaRevisionPtoInspeccion);
          await PtosInspeccionServices().postPtoInspeccionAccion(context, orden, nuevaRevisionPtoInspeccion, token);
        }
      } else{
        if(puntosSeleccionados[i].piAccionId != 0 && puntosSeleccionados[i].piAccionId != null ){
          await PtosInspeccionServices().putPtoInspeccionAccionOffline(orden, nuevaRevisionPtoInspeccion);
        }else{
          revision.revisionPtoInspeccion.add(nuevaRevisionPtoInspeccion);// es tu post
        }   
      }
    }

    await actualizarDatos();
    limpiarDatos();

    await PtosInspeccionServices.showDialogs(context, 'Punto guardado', true, false);
  }

  Future marcarPINuevo(int idPIAccion, ZonaPI zonaSeleccionada, String sector, String comentario) async {
    RevisionPtoInspeccion nuevaRevisionPtoInspeccion = RevisionPtoInspeccion(
      otPuntoInspeccionId: puntosSeleccionados.isNotEmpty ? puntosSeleccionados[0].otPuntoInspeccionId : 0,
      ordenTrabajoId: orden.ordenTrabajoId,
      otRevisionId: orden.otRevisionId,
      puntoInspeccionId: 0,
      planoId: 0,
      tipoPuntoInspeccionId: selectedTipoPto.tipoPuntoInspeccionId,
      codTipoPuntoInspeccion: '',
      descTipoPuntoInspeccion: '',
      plagaObjetivoId: plagaObjetivoSeleccionada.plagaObjetivoId,
      codPuntoInspeccion: codPuntoInspeccionController.text,
      codigoBarra: codigoBarraController.text,
      zona: zonaSeleccionada.codZona,
      sector: sector,
      idPIAccion: idPIAccion,
      piAccionId: 1,
      codAccion: '1',
      descPiAccion: '',
      comentario: comentario,
      materiales: [],
      plagas: [],
      tareas: [],
      trasladoNuevo: [],
      seleccionado: false
    );

    if (nuevaRevisionPtoInspeccion.otPuntoInspeccionId != 0) {
      await PtosInspeccionServices().putPtoInspeccionAccion(
        context, orden, nuevaRevisionPtoInspeccion, token);
    } else {
      await PtosInspeccionServices().postPtoInspeccionAccion(
        context, orden, nuevaRevisionPtoInspeccion, token);
    }

    await actualizarDatos();
    limpiarDatos();

    PtosInspeccionServices.showDialogs(context, 'Punto guardado', true, false);
  }

  void limpiarDatos() {
    codPuntoInspeccionController.clear();
    codigoBarraController.clear();
    comentarioController.clear();
    sectorController.clear();
    seleccionados == 0;
  }

  Future<void> actualizarDatos() async {
    bool isConnected = await _checkConnectivity();
    if(isConnected){
      ptosInspeccion = await PtosInspeccionServices().getPtosInspeccion(context, orden, token);
      plagasObjetivo = await PlagaServices().getPlagasObjetivo(context, token);
    }
    setState(() {});
  }

  Future borrarAcciones() async {
    for (var i = 0; i < puntosSeleccionados.length; i++) {
      await PtosInspeccionServices().deleteAccionesPI(context, orden, puntosSeleccionados[i], token);
    }
    await actualizarDatos();
    await PtosInspeccionServices.showDialogs(context, 'Acciones borradas', true, false);
  }

  Future borrarAccion() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmación'),
          content: const Text(
            'Se eliminará toda la información ingresada para los puntos seleccionados. Desea confirmar la acción?',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
            TextButton(
              onPressed: () {
                borrarAcciones();
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      }
    );
  }

  Future<bool> _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

}