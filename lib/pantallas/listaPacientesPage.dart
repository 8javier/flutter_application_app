import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../modelos/paciente_datos.dart';
import '../modelos/provider/profesional_provider.dart';
class ListaPacientePage extends StatefulWidget {
  const ListaPacientePage({super.key});
  @override
  State<ListaPacientePage> createState() => _ListaPacientePageState();
}
class _ListaPacientePageState extends State<ListaPacientePage> {
 @override
  void initState() {
    super.initState();
    // Carga los pacientes del profesional al iniciar la página
    final profesionalProvider = Provider.of<ProfesionalProvider>(context, listen: false);
    profesionalProvider.cargarPacientesLista();
  }

  @override
  Widget build(BuildContext context) {
    final profesionalProvider = Provider.of<ProfesionalProvider>(context);
    final List<Paciente> pacientes = profesionalProvider.pacientesLista;
      return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Pacientes'),
      ),
      body: ListView.builder(
        itemCount: pacientes.length,
        itemBuilder: (context, index) {
          Paciente paciente = pacientes[index]; // Carga para mostrar la info en pantalla
            return ListTile(
            title: Text(paciente.nombre ?? ''),
            subtitle: Text(paciente.apellido ?? ''),
        trailing: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      IconButton(
        icon: const Icon(Icons.message),
        onPressed: () {
          enviarMensaje(paciente); // Llama a la función para enviar el mensaje al paciente
        },
      ),
      IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          eliminarPaciente(paciente); // Llama a la función para eliminar el paciente
        },
      ),
    ],
  ),
          );
        },
      ),
    );
  }

Future<void> enviarMensaje(Paciente paciente) async {
  final profesionalProvider = Provider.of<ProfesionalProvider>(context, listen: false);
  // Captura la información del paciente seleccionado
  final pacienteId = paciente.id;
  final collectionReference = FirebaseFirestore.instance.collection("paciente/$pacienteId");
  // Verifica si la subcolección "mensajeProfesional" existe
  final subcollectionReference = collectionReference.doc(pacienteId).collection("mensajeProfesional");
  final snapshot = await subcollectionReference.get();
  if (snapshot.docs.isEmpty) {
    print('La colección "mensajeProfesional" no existe. Creando...');
    await subcollectionReference.doc().set({});
    print('La colección "mensajeProfesional" ha sido creada con éxito.');
  } else {
    print('La colección "mensajeProfesional" ya existe.');
  }
  // Agrega el mensaje al documento en la subcolección
  await subcollectionReference.add({
    "mensaje": "Este es un mensaje para el paciente",
    "fecha": DateTime.now(),
  });
}
  void eliminarPaciente(Paciente paciente) {// funcion que elimina de la DB del peofesional
    final profesionalProvider = Provider.of<ProfesionalProvider>(context, listen: false);
    profesionalProvider.eliminarPaciente(paciente);
  }
}