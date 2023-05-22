import 'package:cloud_firestore/cloud_firestore.dart';

// funciones para la administracion en firebase

FirebaseFirestore db = FirebaseFirestore.instance;

//------- Funcion q carga Pacientes de la base
Future<List>getPacientes() async{
List personas = [];// <-- variable para almacenar lista de datos pedidos
// Haciendo referencias para la base de datos(pide los datos a la base )

CollectionReference collectionReferencePersonas = db.collection('Pacientess');// <-- variable para almacenar los datos pedidos[de una colleccion existente en la base]

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
  CollectionReference collectionReferenceProfesionales = db.collection('Profesionales');
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
          'matricula':data['matricula'],
              
        };
        profesionales.add(profesional);
      }
      return profesionales;
}
// ---------------------------------------------------[Funciones para uso de pruevas]-----------------------------------
// -----funcion que guarda Pacientes en la base-----------PARA TESTING---------  
Future<void> addPaciente(String name, String apellido)async{
  await db.collection('pacientes').add({'nombre':name,'apellido':apellido},);
}

// -----funcion que Actualiza Pacientes en la base-----------------PARA TESTING
Future<void>actualizaPersonas(String uid,String newApellido,String newNombre)async{
  await db.collection('pacientes').doc(uid).set({'apellido':newApellido,'nombre':newNombre});
}
// -----funcion que Borra Pacientes en la base-----------------PARA TESTING
Future<void>borradoPersona(String uid) async{
await db.collection('pacientes').doc(uid).delete();
}
// ---------------------------------------------------[]--------------------------------------------


// ---------------------------------------------------[ ABM ]------------------e-----------
// -----funcion que guarda Profesional en la base-----------
Future<void> addProfesional(String nombre, String apellido,String celular,String dni,String matricula)async{
  await db.collection('Profesionales').add({'nombre':nombre,'apellido':apellido,'celular':celular,'dni':dni,'matricula':matricula},);
}

// -----funcion que guarda Paciente en la base-----------
Future<void> addPacientes(String name, String apellido,String celular,String dni)async{
  await db.collection('Pacientess').add({'nombre':name,'apellido':apellido,'celular':celular,'dni':dni},);
}
// ---------------------------------------------------[BORRADO]------------------e-----------
// -----funcion que Borra Pacientess en la base-----------
Future<void>borradoPaciente(String uid) async{
await db.collection('Pacientess').doc(uid).delete();
}
// -----funcion que Borra Profesional en la base-----------
Future<void>borradoProfesional(String uid) async{
await db.collection('Profesional').doc(uid).delete();
}
// ---------------------------------------------------[MODIFICA]-----------------------------------
Future<void>actualizaPaciente(String uid,String newApellido,String newNombre,String newCelular,String dni)async{
  await db.collection('Pacientess').doc(uid).set({'apellido':newApellido,'nombre':newNombre,'celular':newCelular,'dni':dni});
}

Future<void>actualizaProfesional(String uid,String newApellido,String newNombre,String newCelular, String newDNI,String newMatricula)async{
  await db.collection('Profesional').doc(uid).set({'apellido':newApellido,'nombre':newNombre,'celular':newCelular,'dni':newDNI,'matricula':newMatricula});
}
// ---------------------------------------------------[]--------------------------------------------