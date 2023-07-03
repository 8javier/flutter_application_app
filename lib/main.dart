import 'dart:convert';
import 'dart:core';

import 'package:background_fetch/background_fetch.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_app/servicios/firebase_service.dart';
import 'package:flutter_application_app/servicios/pedometerService.dart';
import 'package:http/http.dart' as http;
//--------------  Paquetes que usa para la conexion a Firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_app/servicios/backgroundFetch/MyAppState.dart';
import 'package:native_notify/native_notify.dart';
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
import 'modelos/paciente_datos.dart';
import 'modelos/paciente_provider.dart';
import 'modelos/provider/profesional_provider.dart';

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
  procesoBackground();
  BackgroundFetch.finish(taskId);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,    
  );
  runApp( MyApp()); // <-----Arranca la App

  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  final PacienteProvider pacienteProvider = PacienteProvider(); // <--- ver
  final ProfesionalProvider profesionalProvider = ProfesionalProvider();// <--- ver

  @override
  MyAppState createState() => new MyAppState();
}

  void procesoBackground() async {
  String? user_id = FirebaseAuth.instance.currentUser?.uid;
  NativeNotify.registerIndieID(user_id);
  NativeNotify.initialize(3130, 'A1zT3zHBX8id4yfogpqoGW', 'AAAAh1kz_Nc:APA91bHdNIPzSpunOZRMsyKJ6vIUctLthugddY_qSpfTSESDf_k3BAhL83r5QiBA-mw9LBUldnJvyiUD-__liaLTnqVcsl-koFph-YkGwZX2U9fLGHm7UpRVES-Y_wnNQMfWhJrsN3Qq', user_id);
  Paciente? paciente = await obtenerPacientePorId(user_id!);
  var pasos = cargarPedometer();

  var estado = paciente?.getEstado();

  if (pasos! < 500) {
    estado = (estado! + 1000)!;
  }
  else if (pasos! < 2000) {
    estado = (estado! + 100)!;
  }
  else if (pasos! >=2000) {
    estado = (estado! + -100)!;
  }
  else if (pasos! < 10000) {
    estado = (estado! + -1000)!;
  }

  if (estado! >= 10000) {
    var profesionalId = paciente?.getProfesional();
    var nombrePaciente = paciente?.getName();
    enviarNotificacion(profesionalId!, 'Alerta ' + nombrePaciente!, 'Se detecto que pueda necesitar atencion!');
  } 
 }


void enviarNotificacion(String id, String title, String body) {
  http.post(
      Uri.parse('https://app.nativenotify.com/api/flutter/notification'),
    headers: <String, String> {
      'Content-Type': 'application/json'
    },
    body: jsonEncode(<String, String>{
      'indieSubID': id,
      'flutterAppId': '3130',
      'flutterAppToken': 'A1zT3zHBX8id4yfogpqoGW',
      'title': title,
      'body': body,
    }),
  );
}

int? cargarPedometer() {
  PedometerService pedometer = new PedometerService();
  pedometer.startListening();
  return pedometer.getTotalSteps();
}



