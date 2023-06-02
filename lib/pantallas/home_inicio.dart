import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_app/componentes/botonNavegapaginas.dart';
import 'package:flutter_application_app/modelos/auth.dart';
import 'package:flutter_application_app/pantallas/NotificacionesScreen.dart';
import 'package:flutter_application_app/pantallas/add_pacientes_page.dart';
import 'package:flutter_application_app/pantallas/auth_page.dart';
import 'package:flutter_application_app/pantallas/homePacientes.dart';
import 'package:flutter_application_app/pantallas/login_or_register.dart';
import 'package:flutter_application_app/pantallas/mainPaciente.dart';
import 'package:flutter_application_app/servicios/firebase_service.dart';
import 'package:collection/collection.dart';
import '../modelos/paciente_datos.dart';
import '../reciclar/drawerpaciente.dart';

//---------[ Funcion que trae los pacientes]-----
List<Paciente> cargarPacientes() {
  List<Paciente> pacientes = [];
  FirebaseFirestore.instance
      .collection('pacientes')
      .get()
      .then((querySnapshot) {
    for (var doc in querySnapshot.docs) {
      Paciente paciente = Paciente.fromMap(doc.data());
      pacientes.add(paciente);
    }
  });
  return pacientes;
} //---------[ Funcion que trae al paciente que inicio sesion con el uid]

Paciente? cargarPacienteEspecifico(String pacienteUid) {
  List<Paciente> pacientes = cargarPacientes();
  Paciente? pacienteEspecifico =
      pacientes.firstWhereOrNull((paciente) => paciente.uid == pacienteUid);
  return pacienteEspecifico;
}

//--------------------
// <-----------------------------[ ESTA PAGINA ES SE MUESTRA SOLO SI INICIO SESION ] ------------------------
class HomeInicio extends StatefulWidget {
  HomeInicio({super.key});

  @override
  State<HomeInicio> createState() => _HomeInicioState();
}

class _HomeInicioState extends State<HomeInicio> {
  User? currentUser;
  String pacienteId = '';
  final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  // ---------------------------------
  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidoController = TextEditingController(text: "");
  TextEditingController celularController = TextEditingController(text: "");
  TextEditingController dniController = TextEditingController(text: "");
  @override
  void initState() {
    super.initState();
    loadCurrentUser(); 
  }

  Future<void> loadCurrentUser() async {  // --
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      currentUser = user;
      if (currentUser != null) {
        pacienteId = currentUser!.uid;
        // Use pacienteId in your functions or actions
        // For example, load specific patient data
        Paciente? pacienteEspecifico = cargarPacienteEspecifico(pacienteId);
        // ...
      }
    });
  }

  // -------------------------------
  Future<Map<String, dynamic>> cargarDatosPaciente(String pacienteId) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("pacientes")
        .doc(pacienteId)
        .get();
    return snapshot.data() as Map<String, dynamic>;
  }

  // ---------------------------------
  @override
  void dispose() {
    nombreController.dispose();
    apellidoController.dispose();
    celularController.dispose();
    dniController.dispose();
    super.dispose();
  }

  // --------------------------   <------- da error no va
  Future<void> guardarDatosPaciente(String pacienteId, Map<String, dynamic> datosPaciente) async {
    try {
      await FirebaseFirestore.instance
          .collection("pacientes")
          .doc(pacienteId)
          .update(datosPaciente);
      scaffoldMessengerKey.currentState?.showSnackBar(const SnackBar(
        content: Text('Los datos del paciente se han guardado correctamente.'),
      ));
    } catch (error) {
      scaffoldMessengerKey.currentState?.showSnackBar(const SnackBar(
        content: Text('Error al guardar los datos del paciente.'),
      ));
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      
      key: scaffoldMessengerKey,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 128, 142, 224),
        appBar: AppBar(
          actions: const [
            IconButton(onPressed: signUserOut, icon: Icon(Icons.logout))
          ],
          title: const Text('Paciente'),
          backgroundColor: const Color.fromARGB(255, 35, 63, 87),
        ),
        body: FutureBuilder<Map<String, dynamic>>(
          future: cargarDatosPaciente(pacienteId),
          builder: (context, snapshot) {          
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              
              return const Text('Error al cargar los datos del paciente');
            } else if (snapshot.hasData) {
              Map<String, dynamic>? datosPaciente = snapshot.data;
              if (datosPaciente != null) {
                return ListView(
               
                  padding: const EdgeInsets.all(16),
                  children: [   
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.person),
                        title: Text('Nombre: ${datosPaciente['nombre']}'),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.person),
                        title: Text('Apellido: ${datosPaciente['apellido']}'),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.phone),
                        title: Text('Celular: ${datosPaciente['celular']}'),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.credit_card),
                        title: Text('DNI: ${datosPaciente['dni']}'),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.email),
                        title: Text('Email: ${datosPaciente['email']}'),
                      ),
                    ),
                    
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.star),
                        title: const Text('Ir a la seccion Pacientes'),
                        onTap: (() async{
                        await Navigator.pushNamed(context,'/HomePaciente');   //- <----- verrr                       
                          setState(() {
                            //<--  A ctualiza los cambios con los de la base para q lo muestre por pantalla
                          });
                        }),
                      ),
                    ),
                    //---------------------- <-----
                  ],
                );
              } else {
                return const Text('No se encontraron datos del paciente');
              }
            } else {
              return const Text('No se encontraron datos del paciente');
            }
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Otra',
            ),
          ],
        ),
      ),
    );
  }
}
//------FUNCION
// void cargarDatos() {
//   pacientes = cargarPacientes();
//  pacienteEspecifico = cargarPacienteEspecifico(user_id);
// }

//---------[ Funcion de logOut de firebase ]
void signUserOut() {
  FirebaseAuth.instance.signOut();
  NavegarBoton(
      texto: "",
      paginaDestino:
          const LoginOrRegisterPage()); // <-lo mandas a esta pantalla que chequea el login
}
