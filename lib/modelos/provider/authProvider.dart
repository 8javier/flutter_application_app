import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_app/modelos/provider/registration_provider.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final RegistrationProvider _registrationProvider;
  String? _userType;
  AuthProvider(this._registrationProvider);

  Future<void> register() async {
    try {
      String email = _registrationProvider.email;
      String password = _registrationProvider.password;
      String name = _registrationProvider.name;
      String specialization = _registrationProvider.specialization;

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Aquí puedes almacenar la información adicional del usuario (nombre, especialización, etc.) en tu base de datos

      _registrationProvider.reset();
      // Puedes realizar alguna acción adicional después de un registro exitoso, como mostrar un mensaje de éxito o redirigir a otra pantalla
    } catch (error) {
      // Manejar el error de registro
    }
  }

  Future<void> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Aquí puedes realizar alguna acción adicional después de un inicio de sesión exitoso, como mostrar una pantalla de inicio de sesión exitoso o redirigir a otra pantalla
    } catch (error) {
      // Manejar el error de inicio de sesión
    }
  }

  void logout() async {
    await _auth.signOut();
    // Puedes realizar alguna acción adicional después de cerrar sesión, como redirigir a la pantalla de inicio de sesión
  }
}














/*
try {
      // Crear usuario en Firebase Authentication
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Obtener el ID del usuario creado
      String userId = userCredential.user!.uid;
      // Crear documento de usuario en la coleccion "users"
      await _firestore.collection('users').doc(userId).set({
        'name': name,
        'email': email,
        'userType': userType,
      });
      // Crear documento de referencia en la colección correspondiente
      if (userType == 'doctor') {
        await _firestore.collection('doctors').doc(userId).set({
          'userRef': _firestore.collection('users').doc(userId),
        });
      } else if (userType == 'patient') {
        await _firestore.collection('patients').doc(userId).set({
          'userRef': _firestore.collection('users').doc(userId),
        });
      }
      // Notificar a los listeners del cambio en el estado
      notifyListeners();
    } catch (error) {
      // Manejar cualquier error que ocurra durante el registro
      print('Error durante el registro: $error');
      throw error;
    }
*/