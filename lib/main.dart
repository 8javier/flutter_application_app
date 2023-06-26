import 'package:flutter/material.dart';
//--------------  Paquetes que usa para la conexion a Firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_app/pantallas/google_inicio.dart';
import 'package:flutter_application_app/pantallas/homePacientes.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

// Servicio de notificaciones
import 'package:flutter/material.dart';
import 'package:native_notify/native_notify.dart';
// --------------------------------------------------------
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  NativeNotify.initialize(3130, 'A1zT3zHBX8id4yfogpqoGW'); // Dejar tranquilos estos dos NULL, por favor.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, 
    
  );
  runApp( MyApp()); // <-----Arranca la App
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
 final PacienteProvider pacienteProvider = PacienteProvider();

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
                ChangeNotifierProvider(create: (_) => PacienteProvider(),)
                 ],
     
      child: MaterialApp(
          title: 'Flutter AppMental',
          debugShowCheckedModeBanner: false,
          initialRoute:  '/auth_page', 
          routes: {
                    //      '/login':(context) => const LoginPage(),
                          '/listaPaciente':(context)=>const Home(),
                          '/edit':(context)=>const editPacientePage(),
                            '/addProfesional':(context)=>const AddProfesionalPage(),
                          '/addPaciente':(context)=>const AddPacientesPage(),
                          '/lisProfesional':(context)=> const ListaProfesionales(),
                          '/auth_page':(context) => const AuthPage(),
                          '/loginOrRegister':(context) => const LoginOrRegisterPage(),
                     //    '/testpage':(context) =>  testPage(),
                     '/HomePaciente':(context) => const HomePaciente(),
                     // '/google':(context) => const SignInDemo(),// <---hay que camviar el puerto a 5000 para que ande con el comando[ flutter run -d chrome --web-hostname localhost --web-port 5000 ]
                  },
                
          ),
    );

  }

}
