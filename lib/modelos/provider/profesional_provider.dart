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
    _profesionalEspecifico = profesional.firstWhereOrNull((profesional) => profesional.getId() == profesionalId);
    isLoading = false;
    notifyListeners();
  }

    Future<void> agregarPacientes(List<Paciente> pacientesSeleccionados) async {
    try {
     // final List<Paciente> pacientes = pacientesLista.where((paciente) {
     //  return pacientesSeleccionados.contains(paciente);
    //  }).toList();
      final profesionalId = _profesionalEspecifico?.id;// <-- ver valor da null !!
      if( profesionalId != null){   
      final collectionReference=FirebaseFirestore.instance.collection("profesional/$profesionalId/listaPacientes"); 
      final subColleccionSnapshot = await collectionReference.get();
          if(subColleccionSnapshot.docs.isEmpty){
              print('La colección "listaPacientes" no existe. Creando...');               
              await collectionReference.doc().set({});
              print('La colección "listaPacientes" ha sido creada con éxito.');
          }else{  
            print('La colección "listaPacientes" ya existe.');}
      for (Paciente paciente in pacientesSeleccionados) {
        print('Datos del paciente: $paciente');
            final pacienteId=paciente.id;
            final pacienteReference = collectionReference.doc(pacienteId);
            await pacienteReference.set(paciente.toMap());
            print('Paciente agregado a la lista su ID es: $pacienteId');
       }
      } else{
         print('El ID del profesional es nulo');
      }
    } catch (error) {
      print('Error al agregar los pacientes: $error');
    }
  }
  void setProfesionalEspecifico(Profesional? profesional) {
    _profesionalEspecifico = profesional;
    notifyListeners();
  }
  
   Future<void> cargarPacientesLista() async {
    try {
      final profesionalId = _profesionalEspecifico?.id;
      if (profesionalId != null) {
        final collectionReference =
            FirebaseFirestore.instance.collection("profesional/$profesionalId/listaPacientes");
        final querySnapshot = await collectionReference.get();
        final pacientes = querySnapshot.docs.map((doc) {
          return Paciente.fromMap(doc.data());
        }).toList();
        _pacientesLista = pacientes.cast<Paciente>();
        notifyListeners();
      }
    } catch (error) {
      print('Error al cargar los pacientes: $error');
    }
  }
  
   Future<void> eliminarPaciente(Paciente paciente) async {
     print('Datos del paciente: $paciente');
    try {
      final profesionalId = _profesionalEspecifico?.id;
      if (profesionalId != null) {
        final collectionReference =
            FirebaseFirestore.instance.collection("profesional/$profesionalId/listaPacientes");
        final pacienteId = paciente.id;
        final pacienteReference = collectionReference.doc(pacienteId);
        await pacienteReference.delete();
        _pacientesLista.remove(paciente);
        notifyListeners();
      }
    } catch (error) {
      print('Error al eliminar el paciente: $error');
    }
  }

  Profesional? get profesionalEspecifico => _profesionalEspecifico;
}
