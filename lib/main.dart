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
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index){
              return Text(snapshot.data?[index]['apellido']); //<-- [saca el dato de la base]
            },
          );
        }),


    );
  }
}
// --------------ROOT APP--------------------------------------









//nom-apellido-telefono-direccion

// --------------sin usar--------------------------------------
// ----------LUGAR DONDE CREA LAS FUNCIONES DE LA APPP---------------------------------
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
// ---------------------------------------------------

// ---------------ES LA PRIMERA RAMA(WIDGET) QUE SALE DEL ROOT(WIDGET-PRINCIPAL) ---------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
