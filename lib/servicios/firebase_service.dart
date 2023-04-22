import 'package:cloud_firestore/cloud_firestore.dart';

// funciones para la administracion en firebase

FirebaseFirestore db = FirebaseFirestore.instance;
//------- Funcion q carga Pacientes de la base
Future<List>getPersonas() async{
List personas = [];// <-- variable para almacenar lista de datos pedidos
// Haciendo referencias para la base de datos(pide los datos a la base )
CollectionReference collectionReferencePersonas = db.collection('pacientes');// <-- variable para almacenar los datos pedidos[de una colleccion existente en la base]

QuerySnapshot queryPacientes = await collectionReferencePersonas.get();// <-- pide todos los pacientes
for (var element in queryPacientes.docs) { 
  personas.add(element.data());
}
return personas;
}

// -----funcion que guarda Pacientes en la base-----------
Future<void> addPaciente(String name, String apellido)async{
  await db.collection('pacientes').add({'nombre':name,'apellido':apellido},);
}