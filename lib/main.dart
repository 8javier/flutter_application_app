import 'package:flutter/material.dart';
//--------------  Paquetes que usa para la conexion a Firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_app/pantallas/google_inicio.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
// --------------------------------------------------------
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    //options: DefaultFirebaseOptions.android, // if you're using windows emulator
    //options: DefaultFirebaseOptions.ios, // para plataforma ios
    options: DefaultFirebaseOptions.currentPlatform, // no usen la opcion windows solo web o android
     //options: DefaultFirebaseOptions.web, 
  );
  runApp(const MyApp()); // <-----Arranca la App
}

// -----------------------------------------------
// ------------
class MyApp extends StatelessWidget {
  const MyApp({super.key});
// --------------ROOT APP--------------------------------------
// This widget is the root of your application.


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter AppMental',
        debugShowCheckedModeBanner: false,
        initialRoute: '/auth_page', // <--- se elige la Pagina de inicial de la App
        routes: {
                  //      '/login':(context) => const LoginPage(),
                        '/':(context)=>const Home(),
                        '/edit':(context)=>const editPacientePage(),
                          '/addProfesional':(context)=>const AddProfesionalPage(),
                        '/addPaciente':(context)=>const AddPacientesPage(),
                        '/lisProfesional':(context)=> const ListaProfesionales(),
                        '/auth_page':(context) => const AuthPage(),
                        '/loginOrRegister':(context) => const LoginOrRegisterPage(),
                   //    '/testpage':(context) =>  testPage(),
                   '/google':(context) => const SignInDemo(),
                },
                      
        );
  }
}
