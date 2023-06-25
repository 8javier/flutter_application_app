import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get usuarioActual => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges=>_firebaseAuth.authStateChanges();
//---------[ 
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  })async{
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email, 
      password: password
      );
  }
    Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  })async{
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email, 
      password: password
      );
  }
  //---------[ crea al Profesional  ]//-despues se agrega la Matricula con la funcion de modificar
  Future<void> createUserProfesionalWithEmailAndPassword({
    required String email,
    required String password,
    required String nombre,
    required String apellido,
    required String celular,
    required String dni,
  })async{
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email, 
      password: password
      );
       addUserData(
          nombre, 
          apellido, 
          celular, 
          dni, 
          email,
          );  
  }
  //---------[ crea al Paciente  ]
  Future<void> createUserPacienteWithEmailAndPassword({
    required String email,
    required String password,
    required String nombre,
    required String apellido,
    required String celular,
    required String dni,
  })async{
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email, 
      password: password
      );
       addUserData(
          nombre, 
          apellido, 
          celular, 
          dni, 
          email,
          );  
  }
  //---------[ cierra la cesion]
  Future<void>singnOut()async{
      await _firebaseAuth.signOut();
  }
  //---------[  Agrega los datos del usuario a la base  ]
  Future addUserData(String nombre,String apellido,String celular,String dni,String email)async{
    await FirebaseFirestore.instance.collection("Pacientess").add({
     'nombre':nombre ,
     'apellido':apellido ,
     'celular': celular,
     'dni': dni,
     'email': email,
    });
  }
}
