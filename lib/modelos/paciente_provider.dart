import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_app/modelos/paciente_datos.dart';
class PacienteProvider extends ChangeNotifier {
  List<Paciente> _pacientes = [];
  List<Paciente> get pacientes => _pacientes;
  Paciente? _pacienteEspecifico;
  bool isLoading = false;

  Future<void> cargarPacientes() async {
    isLoading = true;
     try {
    final querySnapshot = await FirebaseFirestore.instance.collection('paciente').get();
    final pacientes = querySnapshot.docs.map((doc) {
      return Paciente.fromMap(doc.data());
    }).toList();
    _pacientes = pacientes;
    isLoading = false;
    notifyListeners();
  } catch (error) {
    print('Error al cargar los pacientes: $error');
  }
  }

  void cargarPacienteEspecifico(String pacienteId) async{
    isLoading = true;
    await cargarPacientes();
    _pacienteEspecifico = pacientes.firstWhereOrNull((paciente) => paciente.uid == pacienteId);
    isLoading = false;
    notifyListeners();
  }

    void setPacienteEspecifico(Paciente? paciente) {
    _pacienteEspecifico = paciente;
    notifyListeners();
  }

  Paciente? get pacienteEspecifico => _pacienteEspecifico;
}
