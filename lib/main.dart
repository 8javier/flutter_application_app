import 'dart:math';

import 'package:flutter/material.dart';
//--------------  Paquetes que usa para la conexion a Firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_app/pantallas/EncuestaScreen.dart';
import 'package:flutter_application_app/pantallas/edit_paciente_page.dart';
import 'firebase_options.dart';
//-------------- ------------------------------------------------------
//  Paginas
import 'package:flutter_application_app/pantallas/add_paciente_page.dart';
import 'package:flutter_application_app/pantallas/home_page.dart';

import 'modelos/encuestas/EncuestaDinamica.dart';
import 'modelos/encuestas/Opcion.dart';
import 'modelos/encuestas/Pregunta.dart';
// --------------------------------------------------------
void main() async {
  // <----Agrega variable[async] // q espera a conectarse a Firebase-Core
  /*WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    //options: DefaultFirebaseOptions.android, // if you're using windows emulator
    //options: DefaultFirebaseOptions.ios, // para plataforma ios
    options: DefaultFirebaseOptions.currentPlatform, // no usen la opcion windows solo web o android
     //options: DefaultFirebaseOptions.web, 
  );*/

  //funcion para crear un encuesta con 10 preguntas random y 3 opciones en cada pregunta tambien random
  EncuestaDinamica generarEncuesta() {
    List<Pregunta> preguntas = [];
    Random random = Random();

    for (int i = 1; i <= 20; i++) {
      List<Opcion> opciones = [];

      for (int j = 1; j <= 3; j++) {
        int peso = random.nextInt(3) + 1;
        opciones.add(Opcion(j, peso, 'Opción $j'));
      }

      int pesoPregunta = random.nextInt(10) + 1;
      preguntas.add(Pregunta(i, pesoPregunta, 'Pregunta $i', opciones, false));
    }

    return EncuestaDinamica(1, preguntas, 0);
  }

  EncuestaDinamica encuesta = generarEncuesta();

  runApp(MyApp(encuesta: encuesta,));


  //runApp(const MyApp()); // <-----Arranca la App
}
class MyApp extends StatelessWidget {
  final EncuestaDinamica encuesta;

  const MyApp({super.key, required this.encuesta});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EncuestaScreen(encuesta: encuesta),
    );
  }
}
// -----------------------------------------------------------
/*class MyApp extends StatelessWidget {
  const MyApp({super.key});
// --------------ROOT APP--------------------------------------
// This widget is the root of your application.


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter AppMental',
        initialRoute:  '/', // <--- se arma la Ruta de las Paginas
        routes: {
          '/':(context)=>const Home(),
         '/add':(context)=>const AddPacientePage(),
         '/edit':(context)=>const editPacientePage(),
        },
        
        );
  }*/

