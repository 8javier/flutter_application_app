import 'package:flutter/material.dart';
//--------------  Paquetes que usa para la conexion a Firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_app/pantallas/edit_paciente_page.dart';
import 'firebase_options.dart';
//-------------- ------------------------------------------------------
//  Paginas
import 'package:flutter_application_app/pantallas/add_paciente_page.dart';
import 'package:flutter_application_app/pantallas/home_page.dart';
// --------------------------------------------------------
void main() async {
  // <----Agrega variable[async] // q espera a conectarse a Firebase-Core
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    //options: DefaultFirebaseOptions.android, // if you're using windows emulator
    //options: DefaultFirebaseOptions.ios, // para plataforma ios
    options: DefaultFirebaseOptions.currentPlatform, // no usen la opcion windows solo web o android
     //options: DefaultFirebaseOptions.web, 
  );

  runApp(const MyApp()); // <-----Arranca la App
}

// -----------------------------------------------------------
class MyApp extends StatelessWidget {
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
  }
}
