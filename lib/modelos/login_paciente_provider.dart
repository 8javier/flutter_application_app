import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'paciente_datos.dart';

class LoginPacienteProvider extends ChangeNotifier {
  Paciente? _paciente;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Paciente? get paciente => _paciente;

  Future<void> login(String email, String password) async {
    try {
      final UserCredential credenciales = await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password);
      final User? user = credenciales.user;
      if (user != null) {
        _paciente = Paciente(email: user.email!, password: '');
        notifyListeners();
      }
    } catch (e) {
      print('Error al iniciar sesión: $e');
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      _paciente = null;
      notifyListeners();
    } catch (e) {
      print('Error al cerrar sesión: $e');
    }
  }
}