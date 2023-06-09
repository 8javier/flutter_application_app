import 'package:flutter/material.dart';
//--------------  Paquetes que usa para la conexion a Firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
//-------------- ------------------------------------------------------
//  Paginas
import 'package:flutter_application_app/pantallas/home_page.dart';
import 'package:flutter_application_app/pantallas/add_pacientes_page.dart';
import 'package:flutter_application_app/pantallas/add_profesional_page.dart';
import 'package:flutter_application_app/pantallas/auth_page.dart';
import 'package:flutter_application_app/pantallas/edit_paciente_page.dart';
import 'package:flutter_application_app/pantallas/lista_profesionales.dart';
import 'package:flutter_application_app/pantallas/login_or_register.dart';
import 'modelos/paciente_provider.dart';

// --------------------------------------------------------



// This "Headless Task" is run when app is terminated.
// Be sure to annotate your callback function to avoid issues in release mode on Flutter >= 3.3.0
@pragma('vm:entry-point')
void backgroundFetchHeadlessTask(HeadlessTask task) async {
  String taskId = task.taskId;
  bool isTimeout = task.timeout;
  if (isTimeout) {
    // This task has exceeded its allowed running-time.  You must stop what you're doing and immediately .finish(taskId)
    print("[BackgroundFetch] Headless task timed-out: $taskId");
    BackgroundFetch.finish(taskId);
    return;
  }
  print("[BackgroundFetch] Headless event received: $taskId");

  BackgroundFetch.finish(taskId);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,    
  );
  runApp( MyApp()); // <-----Arranca la App

}
