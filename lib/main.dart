import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//--------------  Paquetes que usa para la conexion a Firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_app/servicios/firebase_service.dart';
import 'firebase_options.dart';

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
    return const MaterialApp(
        title: 'Flutter AppMental',
        home: Home()
        
        );
  }
}

class Home extends StatefulWidget {// <-es una extraccion de home:home()
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('data')
      ),
      
      body: FutureBuilder(
        future: getPersonas(),         // <-llama a la funcion declarada en la carpeta servicion
        builder:(context, snapshot){ //<-snapshot recibe getPersonas()
        if(snapshot.hasData){//<-snapshot si no esta NULL lo muestra
             return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index){
              return Text(snapshot.data?[index]['apellido']); //<-- [saca el dato de la base]
            },
          );
          
        } else{return const Center(//<-snapshot si esta NULL 
          child: CircularProgressIndicator(),//<-pinta un circulo
        );
        }
      
        }),


    );
  }
}
// --------------ROOT APP--------------------------------------









//nom-apellido-telefono-direccion
