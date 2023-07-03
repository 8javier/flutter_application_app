import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../modelos/paciente_datos.dart';

// funciones para la administracion en firebase

FirebaseFirestore db = FirebaseFirestore.instance;

//------- Funcion q carga Pacientes de la base
Future<List>getPacientes() async{
List personas = [];// <-- variable para almacenar lista de datos pedidos
// Haciendo referencias para la base de datos(pide los datos a la base )

CollectionReference collectionReferencePersonas = db.collection('paciente');// <-- variable para almacenar los datos pedidos[de una colleccion existente en la base]

QuerySnapshot queryPacientes = await collectionReferencePersonas.get();// <-- pide todos los pacientes esperando que la DB se los envie
for (var doc in queryPacientes.docs) { 

  final Map<String,dynamic> data = doc.data() as Map<String,dynamic>;// <-- transforma la data en un Mapa(clavve,valor)
final person = {    // <-- crea el objeto person con sus propiedades
  'apellido':data['apellido'],
  'nombre': data['nombre'],
  'celular':data['celular'],
  'dni':data['dni'],
  'uid':doc.id,
};
  personas.add(person);
}
return personas;
}
//------- Funcion q carga Profesionales de la base  ----------------------------------------------

Future<List>getProfesionles()async{
  CollectionReference collectionReferenceProfesionales = db.collection('profesional');
  QuerySnapshot queryProfesionales = await collectionReferenceProfesionales.get();
 List profesionales = [];
      for (var doc in queryProfesionales.docs) {
        final Map<String,dynamic>data=doc.data()as Map<String,dynamic>;
        final profesional = {
          'id':doc.id,
          'nombre':data['nombre'],
          'apellido':data['apellido'],
          'celular':data['celular'],
          'dni':data['dni'],
        };
        profesionales.add(profesional);
      }
      return profesionales;
}
// ---------------------------------------------------[BORRADO]------------------e-----------
// -----funcion que Borra Pacientess en la base-----------
Future<void>borradoPaciente(String uid) async{
await db.collection('paciente').doc(uid).delete();
}
// -----funcion que Borra Profesional en la base-----------
Future<void>borradoProfesional(String uid) async{
await db.collection('profesional').doc(uid).delete();
}
// ---------------------------------------------------[MODIFICA]-----------------------------------
Future<void>actualizaPaciente(String uid,String newApellido,String newNombre,String newCelular,String dni)async{
  await db.collection('paciente').doc(uid).update({'apellido':newApellido,'nombre':newNombre,'celular':newCelular,'dni':dni});
}

Future<void>actualizaProfesional(String uid,String newApellido,String newNombre,String newCelular, String newDNI,)async{
  await db.collection('profesional').doc(uid).update({'apellido':newApellido,'nombre':newNombre,'celular':newCelular,'dni':newDNI,});
}
// ---------------------------------------------------[]--------------------------------------------
//---------[ Funcion que trae los pacientes]-----
List<Paciente> cargarPacientes() {
  List<Paciente> pacientes = [];
  FirebaseFirestore.instance
      .collection('paciente')
      .get()
      .then((querySnapshot) {
    for (var doc in querySnapshot.docs) {
      Paciente paciente = Paciente.fromMap(doc.data());
      pacientes.add(paciente);
    }
  });
  return pacientes;
} 
//--------------------
Paciente? cargarPacienteEspecifico(String pacienteUid) {
  List<Paciente> pacientes = cargarPacientes();
  Paciente? pacienteEspecifico =
      pacientes.firstWhereOrNull((paciente) => paciente.uid == pacienteUid);
  return pacienteEspecifico;
}
//--------------------
  Future<Map<String, dynamic>> cargarDatosPaciente(String pacienteId) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("paciente")
        .doc(pacienteId)
        .get();
    return snapshot.data() as Map<String, dynamic>;
  }
//--------------------