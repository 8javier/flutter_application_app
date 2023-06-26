import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_app/componentes/botonNavegapaginas.dart';
import 'package:flutter_application_app/modelos/profesional_datos.dart';
import 'package:flutter_application_app/modelos/provider/profesional_provider.dart';
import 'package:flutter_application_app/pantallas/login_or_register.dart';
import 'package:collection/collection.dart';
import '../modelos/paciente_datos.dart';
import '../modelos/paciente_provider.dart';
import 'package:provider/provider.dart';

//---------[ Funcion que trae los pacientes] <- no  se usa esta funcion se usa la funcion del 'Paciente_provider'\
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
}
//---------[ Funcion que trae los profesionales] <- no  se usa esta funcion se usa la funcion del 'Profesional_provider'\
List<Profesional> cargaProfesional() {
  List<Profesional> profesionales = [];
  FirebaseFirestore.instance
      .collection('profecional')
      .get()
      .then((QuerySnapshot) {
    for (var doc in QuerySnapshot.docs) {
      Profesional profesional = Profesional.fromMap(doc.data());
      profesionales.add(profesional);
    }
  });
  return profesionales;
}
//---------[ Funcion que trae al profesional que inicio sesion con el uid] <- no  se usa esta funcion se usa la funcion del 'Profesional_provider'\
Profesional? cargaProfesionalEspecifico(String profesionalUid) {
  List<Profesional> profesionales = cargaProfesional();
  Profesional? profesionalEspecifico = profesionales
      .firstWhereOrNull((profesional) => profesional.uid == profesionalUid);
  return profesionalEspecifico; //-- Trae al Profesional
}
//---------[ Funcion que trae al paciente que inicio sesion con el uid] <- no  se usa esta funcion se usa la funcion del 'Paciente_provider'\
Paciente? cargarPacienteEspecifico(String pacienteUid) {
  List<Paciente> pacientes = cargarPacientes();
  Paciente? pacienteEspecifico =
      pacientes.firstWhereOrNull((paciente) => paciente.uid == pacienteUid);
  return pacienteEspecifico;
}
// <-----------------------------[ ESTA PAGINA ES SE MUESTRA SOLO SI INICIO SESION ] ------------------------
class HomeInicio extends StatefulWidget {
  const HomeInicio({super.key});
  @override
  State<HomeInicio> createState() => _HomeInicioState();
}

class _HomeInicioState extends State<HomeInicio> {
  User? currentUser;
  final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  // ---------------------------------
  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidoController = TextEditingController(text: "");
  TextEditingController celularController = TextEditingController(text: "");
  TextEditingController dniController = TextEditingController(text: "");
  @override
  void initState() {
    super.initState();
  }
   String userId=FirebaseAuth.instance.currentUser!.uid;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
      String user_id = FirebaseAuth.instance.currentUser!.uid;  
      final pacienteProvider = Provider.of<PacienteProvider>(context,listen: false); // <----- checar inicialización de la variable
      final profesionalProvider = Provider.of<ProfesionalProvider>(context,listen: false); // <-----  checar inicialización de la variable

      if (!pacienteProvider.isLoading && pacienteProvider.pacienteEspecifico == null) {
        pacienteProvider.cargarPacientes();
        pacienteProvider.cargarPacienteEspecifico(user_id);
      }
      if (!profesionalProvider.isLoading && profesionalProvider.profesionalEspecifico == null) {
        profesionalProvider.cargarProfesional();
        profesionalProvider.cargarProfesionalEspecifico(user_id);
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
            IconButton(onPressed: (signUserOut), icon: Icon(Icons.logout))
          ],
          title: const Text('Inicio'),
          backgroundColor: const Color.fromARGB(255, 35, 63, 87),
        ),
        //----------------------------------------------------------------------
        body: Column(
          children: [
            Expanded(child:
            Consumer<PacienteProvider>(
              builder: (context, pacienteProvider, _) {
                if (pacienteProvider.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  ); 
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
                              await Navigator.pushNamed(
                                  context, '/HomePaciente');
                              //  WidgetsBinding.instance.addPostFrameCallback((_) {
                              //     final pacienteProvider = Provider.of<PacienteProvider>(context, listen: false);
                              //     pacienteProvider.cargarPacienteEspecifico(pacienteId);
                              //   });
                              setState(() {});
                            }),
                          ),
                        ),
                       
                      ],
                    );
                  } else {
                    return Consumer<ProfesionalProvider>(
                      builder: (context, profesionalProvider, _) {
                        if (profesionalProvider.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          ); 
                        } else {
                          Profesional? datosProfesional =
                              profesionalProvider.profesionalEspecifico;
                          if (datosProfesional != null) {
                            return ListView(
                              padding: const EdgeInsets.all(16),
                              children: [
                                Card(
                                  child: ListTile(
                                    leading: const Icon(Icons.person),
                                    title:
                                        Text('Nombre: ${datosProfesional.nombre}'),
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: const Icon(Icons.person),
                                    title: Text(
                                        'Apellido: ${datosProfesional.apellido}'),
                                  ),
                                ),
                                  Card(
                              child: ListTile(
                              leading: const Icon(Icons.star),
                              title: const Text('admin Pacientes'),
                              onTap: (() async {
                              await Navigator.pushNamed(
                                  context, '/listaPaciente');
                              setState(() {});
                            }),
                          ),
                        ),
                            Card(
                              child: ListTile(
                              leading: const Icon(Icons.star),
                              title: const Text('Agregar Pacientes'),
                              onTap: (() async {
                              await Navigator.pushNamed(
                                  context, '/AgragarPaciente');
                              setState(() {});
                            }),
                          ),
                        ),
                              ],
                            );
                          } else {
                            return const Text(
                                'No se encontraron datos del paciente o doctor');
                          }
                        }
                      },
                    );
                  }
                }
              },
            ),
            ),
          ],
        ),
        //----------------------------------------------------------------------
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


/*
  children: [
            Consumer<PacienteProvider>(
              builder: (context, pacienteProvider, _) {
                if (pacienteProvider.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  ); 
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
                              await Navigator.pushNamed(
                                  context, '/HomePaciente');
                              //  WidgetsBinding.instance.addPostFrameCallback((_) {
                              //     final pacienteProvider = Provider.of<PacienteProvider>(context, listen: false);
                              //     pacienteProvider.cargarPacienteEspecifico(pacienteId);
                              //   });
                              setState(() {});
                            }),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            leading: const Icon(Icons.star),
                            title: const Text('admin Pacientes'),
                            onTap: (() async {
                              await Navigator.pushNamed(
                                  context, '/listaPaciente');
                              setState(() {});
                            }),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Consumer<ProfesionalProvider>(
                      builder: (context, profesionalProvider, _) {
                        if (profesionalProvider.isLoading) {
                          return Center(
                            child: CircularProgressIndicator(),
                          ); 
                        } else {
                          Profesional? datosProfesional =
                              profesionalProvider.profesionalEspecifico;
                          if (datosProfesional != null) {
                            return ListView(
                              padding: const EdgeInsets.all(16),
                              children: [
                                Card(
                                  child: ListTile(
                                    leading: const Icon(Icons.person),
                                    title:
                                        Text('Nombre: ${datosProfesional.nombre}'),
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: const Icon(Icons.person),
                                    title: Text(
                                        'Apellido: ${datosProfesional.apellido}'),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return const Text(
                                'No se encontraron datos del paciente o doctor');
                          }
                        }
                      },
                    );
                  }
                }
              },
            ),
          ],
*/