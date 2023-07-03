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
  Profesional? datosProfesional;
   Paciente? datosPaciente;
 //   Profesional? _profesionalEspecifico;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
      final pacienteProvider = Provider.of<PacienteProvider>(context,listen: false);
      final profesionalProvider = Provider.of<ProfesionalProvider>(context,listen: false);

      if (!pacienteProvider.isLoading ) {
        pacienteProvider.cargarPacientes();
        cargarPacienteEspecifico1(pacienteProvider,userId);
      }
        if (!profesionalProvider.isLoading) {
         profesionalProvider.cargarProfesional();
      cargarProfesionalEspecifico1(profesionalProvider, userId);
     }
  }
     Future<void> cargarProfesionalEspecifico1(
     ProfesionalProvider profesionalProvider, String profesionalId) async {
    await profesionalProvider.cargarProfesional();
    final profesionalEspecifico = profesionalProvider.profesional
        .firstWhereOrNull((profesional) => profesional.uid == profesionalId);
        profesionalProvider.setProfesionalEspecifico(profesionalEspecifico);
    setState(() {
      datosProfesional = profesionalEspecifico;
   //    _profesionalEspecifico = profesionalEspecifico;
    });
  }
   Future<void> cargarPacienteEspecifico1(
     PacienteProvider pacienteProvider, String pacienteId) async {
    await pacienteProvider.cargarPacientes();
    final pacienteEspecifico= pacienteProvider.pacientes
        .firstWhereOrNull((paciente) => paciente.id == pacienteId);
        pacienteProvider.setPacienteEspecifico(pacienteEspecifico);
    setState(() {
      datosPaciente = pacienteEspecifico;
    });
  }
  @override
  void dispose() {
    nombreController.dispose();
    apellidoController.dispose();
    celularController.dispose();
    dniController.dispose();
    datosProfesional=null;
    datosPaciente=null;
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
          title: const Text('Home'),
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
                  if (datosPaciente != null && datosPaciente?.id== userId) {
                    return ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        Card(
                          child: ListTile(
                            leading: const Icon(Icons.person),
                            title: Text('Nombre: ${datosPaciente?.nombre}'),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            leading: const Icon(Icons.person),
                            title: Text('Apellido: ${datosPaciente?.apellido}'),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            leading: const Icon(Icons.phone),
                            title: Text('Celular: ${datosPaciente?.celular}'),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            leading: const Icon(Icons.credit_card),
                            title: Text('DNI: ${datosPaciente?.dni}'),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            leading: const Icon(Icons.email),
                            title: Text('Email: ${datosPaciente?.email}'),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            leading: const Icon(Icons.star),
                            title: const Text('Ir a la seccion Pacientes'),
                            onTap: (() async {
                              await Navigator.pushNamed(
                                  context, '/HomePaciente');
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
                           
                          if (datosProfesional != null && datosProfesional?.id== userId) {
                            return ListView(
                              padding: const EdgeInsets.all(16),
                              children: [
                                Card(
                                  child: ListTile(
                                    leading: const Icon(Icons.person),
                                    title:
                                        Text('Nombre: ${datosProfesional?.nombre}'),
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: const Icon(Icons.person),
                                    title: Text(
                                        'Apellido: ${datosProfesional?.apellido}'),
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
                              leading: const Icon(Icons.add_box_sharp),
                              title: const Text('Agregar Pacientes'),
                              onTap: (() async {
                              await Navigator.pushNamed(
                                  context, '/AgragarPaciente');
                              setState(() {});
                            }),
                          ),
                        ),
                           Card(
                              child: ListTile(
                              leading: const Icon(Icons.account_box_outlined),
                              title: const Text('My lista de Pacientes'),
                              onTap: (() async {
                              await Navigator.pushNamed(
                                  context, '/ListaPacientePage');
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

//---------[ Funcion de logOut de firebase ]
void signUserOut() async {
  try{
    await  FirebaseAuth.instance.signOut();
  NavegarBoton(
      texto: "Salir",
      paginaDestino:
          const LoginOrRegisterPage()); 
  }catch (error) {
    print('Error al cerrar la sesión: $error');
  }
}

