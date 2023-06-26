import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_app/modelos/paciente_datos.dart';
import 'package:flutter_application_app/modelos/profesional_datos.dart';
class ProfesionalProvider extends ChangeNotifier {
  List<Profesional> _profesional = [];
  List<Profesional> get profesional => _profesional;
  Profesional? _profesionalEspecifico;
  List<Paciente> _pacientesLista = [];
  List<Paciente> get pacientesLista => _pacientesLista;
  bool isLoading = false;

  Future<void> cargarProfesional() async {
  isLoading = true;

  try {
    final querySnapshot = await FirebaseFirestore.instance.collection('profesional').get();
    final profesional = querySnapshot.docs.map((doc) {
      return Profesional.fromMap(doc.data());
    }).toList();
    _profesional = profesional.cast<Profesional>();
    isLoading = false;
    notifyListeners();
  } catch (error) {
    print('Error al cargar los profesionales: $error');
  }
}

  void cargarProfesionalEspecifico(String profesionalId) async{
    isLoading = true;
    await cargarProfesional();
    _profesionalEspecifico = profesional.firstWhereOrNull((profesional) => profesional.uid == profesionalId);
    isLoading = false;
    notifyListeners();
  }

    Future<void> agregarPacientes(List<Paciente> pacientesSeleccionados) async {
    try {
      final List<Paciente> pacientes = pacientesLista.where((paciente) {
        return pacientesSeleccionados.contains(paciente);
      }).toList();
      if(_profesionalEspecifico?.id != null){
      final profesionalId = _profesionalEspecifico?.id; // carga el ID del profesional actual
      final collectionReference = FirebaseFirestore.instance.collection('profesional').doc(profesionalId).collection('listaPacientes'); // ver carga en la base hay error
      for (final paciente in pacientes) {
        final pacienteId= paciente.dni;// carga al paciente con el ID\ver para guardar mas datos
        await collectionReference.doc(pacienteId).set(paciente.toMap());
      }}else{
         print('Error al agregar los pacientes');
      }
    } catch (error) {
      print('Error al agregar los pacientes: $error');
    }
  }

  Profesional? get profesionalEspecifico => _profesionalEspecifico;
}
