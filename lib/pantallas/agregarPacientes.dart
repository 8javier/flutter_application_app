import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_app/modelos/paciente_datos.dart';
import 'package:provider/provider.dart';

import '../modelos/paciente_provider.dart';
import '../modelos/provider/profesional_provider.dart';

class AgregarPacientePage extends StatefulWidget {
  const AgregarPacientePage({Key? key}) : super(key: key);

  @override
  State <AgregarPacientePage> createState() => _AgregarPacientePageState();
}

class _AgregarPacientePageState extends State<AgregarPacientePage> {
  List<String> pacientesSeleccionados = [];

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Paciente'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('paciente').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final pacientes = snapshot.data!.docs;

            return ListView.builder(
              itemCount: pacientes.length,
              itemBuilder: (context, index) {
                final paciente = Paciente.fromMap(pacientes[index].data() as Map<String, dynamic>);

                return ListTile(
                  title: Text(paciente.nombre ?? ''),
                  subtitle: Text(paciente.apellido ?? ''),
                  trailing: pacientesSeleccionados.contains(paciente.id ?? '')
                      ? const Icon(Icons.check_box)
                      : const Icon(Icons.check_box_outline_blank),
                  onTap: () {
                    setState(() {
                      final pacienteId = pacientes[index].id;
                      if (pacientesSeleccionados.contains(pacienteId)) {
                        pacientesSeleccionados.remove(pacienteId);
                      } else {
                        pacientesSeleccionados.add(pacienteId);
                      }
                    });
                  },
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         // Obtener las instancias de PacienteProvider y ProfesionalProvider
          final pacienteProvider = Provider.of<PacienteProvider>(context, listen: false);
          final profesionalProvider = Provider.of<ProfesionalProvider>(context, listen: false);
          // Obtener los pacientes seleccionados a través de sus IDs
          final List<Paciente> pacientes = pacienteProvider.pacientes.where((paciente) {
            return pacientesSeleccionados.contains(paciente.id);
          }).toList();
          // Agregar los pacientes seleccionados a la lista del profesional
          profesionalProvider.agregarPacientes(pacientes);
          Navigator.pop(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}