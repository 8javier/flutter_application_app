import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_app/componentes/botonNavegapaginas.dart';
import 'package:flutter_application_app/pantallas/login_or_register.dart';
import 'package:collection/collection.dart';
import '../modelos/paciente_datos.dart';
import '../modelos/paciente_provider.dart';
import 'package:provider/provider.dart';
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
  const HomeInicio({super.key});

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
    cargarPacientes();
  }

 @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final pacienteProvider = Provider.of<PacienteProvider>(context, listen: false);
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      pacienteId = user.uid;
      pacienteProvider.cargarPacientes(); // Load patients using PacienteProvider
      pacienteProvider.cargarPacienteEspecifico(pacienteId); // Load specific patient data
    }
  }

  @override
  void dispose() {
    nombreController.dispose();
    apellidoController.dispose();
    celularController.dispose();
    dniController.dispose();
    super.dispose();
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
      body: Consumer<PacienteProvider>(
        builder: (context, pacienteProvider, _) {
          if (pacienteProvider.isLoading) {
            return const CircularProgressIndicator();
          } else {
            Paciente? datosPaciente = pacienteProvider.pacienteEspecifico;
            if (datosPaciente != null) {
              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.person),
                      title: Text('Nombre: ${datosPaciente.nombre}'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.person),
                      title: Text('Apellido: ${datosPaciente.apellido}'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.phone),
                      title: Text('Celular: ${datosPaciente.celular}'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.credit_card),
                      title: Text('DNI: ${datosPaciente.dni}'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.email),
                      title: Text('Email: ${datosPaciente.email}'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.star),
                      title: const Text('Ir a la seccion Pacientes'),
                      onTap: (() async {
                        await Navigator.pushNamed(context, '/HomePaciente');
                        pacienteProvider.cargarPacienteEspecifico(pacienteId);
                      }),
                    ),
                  ),
                ],
              );
            } else {
              return const Text('No se encontraron datos del paciente');
            }
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
