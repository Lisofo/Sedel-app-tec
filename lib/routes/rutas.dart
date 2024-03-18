import 'package:flutter/material.dart';
import '../pages/pages.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return <String, WidgetBuilder>{
    '/': (context) => const Login(),
    'entradaSalida': (context) => const EntradSalida(),
    'listaOrdenes': (context) => const ListaOrdenes(),
    'ordenInterna': (context) => const OrdenInterna(),
    'tareas': (context) => const TareasPage(),
    'plagas': (context) => const PlagasPage(),
    'ptosInspeccion': (context) => const PtosInspeccionPage(),
    'materiales': (context) => const MaterialesPage(),
    // 'materialesDiagnostico': (context) => MaterialesDiagnosticoPage(),
    "observaciones": (context) => const ObservacionesPage(),
    "firmas": (context) => const Firma(),
    "cuestionario": (context) => const CuestionarioPage(),
    "validacion": (context) => const ValidacionPage(),
    // 'ptosInspeccionActividad/mantenimiento': (context) =>
    //     PtosInspeccionActividad(),
  };
}
