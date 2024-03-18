import 'package:app_tecnicos_sedel_wifiless/models/lote.dart';
import 'package:app_tecnicos_sedel_wifiless/models/metodo_aplicacion.dart';
import 'package:app_tecnicos_sedel_wifiless/models/revision_materiales.dart';
import 'package:app_tecnicos_sedel_wifiless/models/revision_plaga.dart';
import 'package:app_tecnicos_sedel_wifiless/models/tarea.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'providers/orden_provider.dart';
import 'offline/boxes.dart';

import 'config/router/router.dart';
import 'models/cargo.dart';
import 'models/cliente.dart';
import 'models/departamento.dart';
import 'models/orden.dart';
import 'models/plaga.dart';
import 'models/servicio_ordenes.dart';
import 'models/tecnico.dart';
import 'models/tipo_cliente.dart';
import 'models/tipo_orden.dart';
import 'models/material.dart';
import 'models/observacion.dart';
import 'models/revision_tarea.dart';

Future<void> main() async {
  await cargarHive(); 

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(ChangeNotifierProvider(
    create: (_) => OrdenProvider(),
    child: const MyApp(),
  ));
}

Future<void> cargarHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(OrdenAdapter());
  Hive.registerAdapter(TipoOrdenAdapter());
  Hive.registerAdapter(TecnicoAdapter());
  Hive.registerAdapter(ClienteAdapter());
  Hive.registerAdapter(ServicioOrdenesAdapter());
  Hive.registerAdapter(CargoAdapter());
  Hive.registerAdapter(DepartamentoAdapter());
  Hive.registerAdapter(TipoClienteAdapter());
  Hive.registerAdapter(PlagaAdapter());
  Hive.registerAdapter(TareaAdapter());
  Hive.registerAdapter(RevisionPlagaAdapter());
  Hive.registerAdapter(RevisionTareaAdapter());
  Hive.registerAdapter(ObservacionAdapter());
  Hive.registerAdapter(MaterialesAdapter());
  Hive.registerAdapter(RevisionMaterialAdapter());
  Hive.registerAdapter(LoteAdapter());
  Hive.registerAdapter(MetodoAplicacionAdapter());
  
  ordenes = await Hive.openBox<Orden>('ordenBox');
  ordenes.clear();
  codigueras = await Hive.openBox('codigueraBox');
  codigueras.clear();
  revisiones = await Hive.openBox('revisionesBox');
  revisiones.clear(); 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      title: 'App Tecnicos SEDEL',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es'), // Spanish
        Locale('en'), // English
      ],
    );
  }
}
