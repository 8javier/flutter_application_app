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
  void initState() { 
    super.initState();
    final pacienteProvider = Provider.of<PacienteProvider>(context, listen: false);
    pacienteProvider.cargarPacientes();
  }
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Paciente'),
        backgroundColor: const Color(0xff0047ab),
      ),
      body: Consumer<PacienteProvider>(
        builder: (context, pacienteProvider, _) {
          if (pacienteProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final pacientes = pacienteProvider.pacientes;

          return ListView.builder(
            itemCount: pacientes.length,
            itemBuilder: (context, index) {
              final paciente = pacientes[index];

              return ListTile(
                title: Text(paciente.nombre ?? ''),
                subtitle: Text(paciente.apellido ?? ''),
                trailing: pacientesSeleccionados.contains(paciente.id ?? '')
                    ? const Icon(Icons.check_box)
                    : const Icon(Icons.check_box_outline_blank),
                onTap: () {
                  setState(() {
                    final pacienteId = paciente.id;// <--- VER POSIBLE CAUSA BUG!!! ver ni no mantiene info vieja!!
                    if (pacienteId != null) {
                    if (pacientesSeleccionados.contains(pacienteId)) {
                      pacientesSeleccionados.remove(pacienteId);
                    } else {
                      pacientesSeleccionados.add(pacienteId);
                    }
                  }
                }
                );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final pacienteProvider = Provider.of<PacienteProvider>(context, listen: false);
          final profesionalProvider = Provider.of<ProfesionalProvider>(context, listen: false);
          final List<Paciente> pacientesLista = pacienteProvider.pacientes.where((paciente) {// <--- VER POSIBLE CAUSA BUG!!!
            return pacientesSeleccionados.contains(paciente.id);// <--- busca los pacientes marcados por el id
          }).toList();
          profesionalProvider.agregarPacientes(pacientesLista);// <--- manda la lista de pacientes marcados para agregarlos al profesional
           ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Pacientes almacenados correctamente'),
            ),
          );
          Navigator.pop(context);
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xff1b5583),
      ),
    );
  }
}