import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../modelos/paciente_provider.dart';
import '../../pantallas/add_pacientes_page.dart';
import '../../pantallas/add_profesional_page.dart';
import '../../pantallas/auth_page.dart';
import '../../pantallas/edit_paciente_page.dart';
import '../../pantallas/homePacientes.dart';
import '../../pantallas/home_page.dart';
import '../../pantallas/lista_profesionales.dart';
import '../../pantallas/login_or_register.dart';

class MyAppState extends State<MyApp> {
  bool _enabled = true;
  int _status = 0;
  List<DateTime> _events = [];

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Configure BackgroundFetch.
    int status = await BackgroundFetch.configure(BackgroundFetchConfig(
        minimumFetchInterval: 15,
        stopOnTerminate: false,
        enableHeadless: true,
        requiresBatteryNotLow: false,
        requiresCharging: false,
        requiresStorageNotLow: false,
        requiresDeviceIdle: false,
        requiredNetworkType: NetworkType.NONE
    ), (String taskId) async {  // <-- Event handler
      // This is the fetch-event callback.



      print("[BackgroundFetch] Event received $taskId");
      setState(() {
        _events.insert(0, new DateTime.now());
      });
      // IMPORTANT:  You must signal completion of your task or the OS can punish your app
      // for taking too long in the background.
      BackgroundFetch.finish(taskId);
    }, (String taskId) async {  // <-- Task timeout handler.
      // This task has exceeded its allowed running-time.  You must stop what you're doing and immediately .finish(taskId)
      print("[BackgroundFetch] TASK TIMEOUT taskId: $taskId");
      BackgroundFetch.finish(taskId);
    });
    print('[BackgroundFetch] configure success: $status');
    setState(() {
      _status = status;
    });

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  void _onClickEnable(enabled) {
    setState(() {
      _enabled = enabled;
    });
    if (enabled) {
      BackgroundFetch.start().then((int status) {
        print('[BackgroundFetch] start success: $status');
      }).catchError((e) {
        print('[BackgroundFetch] start FAILURE: $e');
      });
    } else {
      BackgroundFetch.stop().then((int status) {
        print('[BackgroundFetch] stop success: $status');
      });
    }
  }

  void _onClickStatus() async {
    int status = await BackgroundFetch.status;
    print('[BackgroundFetch] status: $status');
    setState(() {
      _status = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PacienteProvider(),)
      ],

      child: MaterialApp(
        title: 'Flutter AppMental',
        debugShowCheckedModeBanner: false,
        initialRoute: '/auth_page',
        routes: {
          //      '/login':(context) => const LoginPage(),
          '/listaPaciente': (context) => const Home(),
          '/edit': (context) => const editPacientePage(),
          '/addProfesional': (context) => const AddProfesionalPage(),
          '/addPaciente': (context) => const AddPacientesPage(),
          '/lisProfesional': (context) => const ListaProfesionales(),
          '/auth_page': (context) => const AuthPage(),
          '/loginOrRegister': (context) => const LoginOrRegisterPage(),
          //    '/testpage':(context) =>  testPage(),
          '/HomePaciente': (context) => const HomePaciente(),
          // '/google':(context) => const SignInDemo(),// <---hay que camviar el puerto a 5000 para que ande con el comando[ flutter run -d chrome --web-hostname localhost --web-port 5000 ]
        },

      ),
    );
  }
}