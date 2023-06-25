import 'package:cloud_firestore/cloud_firestore.dart';

import '../modelos/encuestas/EncuestaDinamica.dart';
import '../modelos/encuestas/Opcion.dart';
import '../modelos/encuestas/Pregunta.dart';

// funciones para la administracion en firebase

FirebaseFirestore db = FirebaseFirestore.instance;

//------- Funcion q carga Pacientes de la base
Future<List>getPersonas() async{
List personas = [];// <-- variable para almacenar lista de datos pedidos
// Haciendo referencias para la base de datos(pide los datos a la base )

CollectionReference collectionReferencePersonas = db.collection('pacientes');// <-- variable para almacenar los datos pedidos[de una colleccion existente en la base]

QuerySnapshot queryPacientes = await collectionReferencePersonas.get();// <-- pide todos los pacientes esperando que la DB se los envie
for (var doc in queryPacientes.docs) { 

  final Map<String,dynamic> data = doc.data() as Map<String,dynamic>;// <-- transforma la data en un Mapa(clavve,valor)
final person = {    // <-- crea el objeto person con sus propiedades
  'apellido':data['apellido'],
  'nombre': data['nombre'],
  'uid':doc.id,
};
  personas.add(person);
}
return personas;
}

// -----funcion que guarda Pacientes en la base-----------
Future<void> addPaciente(String name, String apellido)async{
  await db.collection('pacientes').add({'nombre':name,'apellido':apellido},);
}

// -----funcion que Actualiza Pacientes en la base-----------
Future<void>actualizaPersonas(String uid,String newApellido,String newNombre)async{
  await db.collection('pacientes').doc(uid).set({'apellido':newApellido,'nombre':newNombre});
}
// -----funcion que Borra Pacientes en la base-----------
Future<void>borradoPersona(String uid) async{
await db.collection('pacientes').doc(uid).delete();
}