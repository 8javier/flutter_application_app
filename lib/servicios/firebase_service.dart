
import 'package:cloud_firestore/cloud_firestore.dart';

// funciones para la administracion en firebase

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List>getPersonas() async{
List personas = [];// <-- variable para almacenar lista de datos pedidos
// Haciendo referencias para la base de datos(pide los datos a la base )
CollectionReference collectionReferencePersonas = db.collection('pacientes');// <-- variable para almacenar los datos pedidos[de una colleccion existente en la base]

QuerySnapshot queryPacientes = await collectionReferencePersonas.get();// <-- pide todos los pacientes

queryPacientes.docs.forEach((element) { 
  personas.add(element.data());
});
return personas;
}

