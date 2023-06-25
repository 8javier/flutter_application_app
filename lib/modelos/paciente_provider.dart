import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_app/modelos/paciente_datos.dart';
class PacienteProvider extends ChangeNotifier {
  List<Paciente> _pacientes = [];
  List<Paciente> get pacientes => _pacientes;
  Paciente? _pacienteEspecifico;
  bool isLoading = false;

  void cargarPacientes() {
    isLoading = true;

    FirebaseFirestore.instance
        .collection('pacientes')
        .get()
        .then((querySnapshot) {
      final pacientes = querySnapshot.docs.map((doc) {
        return Paciente.fromMap(doc.data());
      }).toList();
      _pacientes = pacientes;
      isLoading = false;
      notifyListeners();
    }).catchError((error) {
      print('Error al cargar los pacientes: $error');
    });
  }

  void cargarPacienteEspecifico(String pacienteId) {
    isLoading = true;
    _pacienteEspecifico = pacientes.firstWhereOrNull((paciente) => paciente.uid == pacienteId);
    isLoading = false;
    notifyListeners();
  }

  Paciente? get pacienteEspecifico => _pacienteEspecifico;
}
