import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_app/modelos/profesional_datos.dart';
class ProfesionalProvider extends ChangeNotifier {
  List<Profesional> _profesional = [];
  List<Profesional> get profesional => _profesional;
  Profesional? _profesionalEspecifico;
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

  Profesional? get profesionalEspecifico => _profesionalEspecifico;
}
