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

CollectionReference collectionReferencePersonas = db.collection('pacientes');// <-- variable para almacenar los datos pedidos[de una colleccion existente en la base]

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
// -----funcion que guarda Profesional en la base----------  <---!! no usar porque genera al profesional con un ID distinto al del Login,
Future<void> addProfesional(String nombre, String apellido,String celular,String dni,String matricula)async{
  await db.collection('Profesionales').add({'nombre':nombre,'apellido':apellido,'celular':celular,'dni':dni,'matricula':matricula},);
}

// -----funcion que guarda Paciente en la base-----------  <---!! no usar porque genera al Paciente con un ID distinto al del Login,
Future<void> addPacientes(String name, String apellido,String celular,String dni)async{
  await db.collection('pacientess').add({'nombre':name,'apellido':apellido,'celular':celular,'dni':dni},);
}
// ---------------------------------------------------[BORRADO]------------------e-----------
// -----funcion que Borra Pacientess en la base-----------
Future<void>borradoPaciente(String uid) async{
await db.collection('paciente').doc(uid).delete();
}
// -----funcion que Borra Profesional en la base-----------
Future<void>borradoProfesional(String uid) async{
await db.collection('Profesional').doc(uid).delete();
}
// ---------------------------------------------------[MODIFICA]-----------------------------------
Future<void>actualizaPaciente(String uid,String newApellido,String newNombre,String newCelular,String dni)async{
  await db.collection('paciente').doc(uid).set({'apellido':newApellido,'nombre':newNombre,'celular':newCelular,'dni':dni});
}

Future<void>actualizaProfesional(String uid,String newApellido,String newNombre,String newCelular, String newDNI,String newMatricula)async{
  await db.collection('Profesional').doc(uid).set({'apellido':newApellido,'nombre':newNombre,'celular':newCelular,'dni':newDNI,'matricula':newMatricula});
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

//------ FUNCIONES PARA VINCULAR/DESVINCULAR ENCUESTAS A PACIENTES Y PROFECIONALES ----

// Función para vincular una encuesta a un paciente
Future<void> vincularEncuestaAPaciente(String pacienteId, String encuestaId) async {
  try {
    // Obtenemos la referencia al documento del paciente
    final pacienteRef = FirebaseFirestore.instance.collection('paciente').doc(pacienteId);

    // Actualizamos el documento del paciente para agregar la referencia de la encuesta
    await pacienteRef.update({
      'encuestasVinculadas': FieldValue.arrayUnion([encuestaId])
    });
  } catch (e) {
    print('Error al vincular encuesta con paciente: $e');
    // Manejo de errores
  }
}

// Función para obtener las encuestas de un paciente
Future<List> obtenerEncuestasDePaciente(String pacienteId) async {
  try {
    // Obtenemos el documento del paciente
    final pacienteDoc = await FirebaseFirestore.instance.collection('paciente').doc(pacienteId).get();

    // Verificamos si el paciente tiene encuestas asociadas
    print(pacienteDoc.exists);
    print(pacienteDoc.data()!.containsKey('encuestasVinculadas'));
    //if (pacienteDoc.exists && pacienteDoc.data()!.containsKey('encuestasVinculadas')) {
    if (pacienteDoc.exists) {
      // Recuperamos las referencias de las encuestas respondidas por el paciente
      final encuestasVinculadas = pacienteDoc['esncuestasVinculadas'] as List<dynamic>;

      // Convertimos las referencias a sus IDs correspondientes
      final encuestasIds = encuestasVinculadas.toList();
      return encuestasIds;
    } else {
      // El paciente no tiene encuestas asociadas
      return [];
    }
  } catch (e) {
    print('Error al obtener encuestas de paciente: $e');
    // Manejo de errores
    return [];
  }
}

// Función para eliminar una encuesta de un paciente
Future<void> eliminarEncuestaDePaciente(String pacienteId, String encuestaId) async {
  try {
    // Obtenemos la referencia al documento del paciente
    final pacienteRef = FirebaseFirestore.instance.collection('paciente').doc(pacienteId);

    // Actualizamos el documento del paciente para remover la referencia de la encuesta
    await pacienteRef.update({
      'encuestasVinculadas': FieldValue.arrayRemove([encuestaId])
    });
  } catch (e) {
    print('Error al eliminar encuesta del paciente: $e');
    // Manejo de errores
  }
}

// Función para vincular una encuesta a un profesional
Future<void> cargarEncuestaAProfesional(String profesionalId, String encuestaId) async {
  try {
    // Obtenemos la referencia al documento del profesional
    final profesionalRef = FirebaseFirestore.instance.collection('Profesional').doc(profesionalId);

    // Actualizamos el documento del profesional para agregar la referencia de la encuesta
    await profesionalRef.update({
      'encuestasCargadas': FieldValue.arrayUnion([encuestaId])
    });
  } catch (e) {
    print('Error al vincular encuesta con profesional: $e');
    // Manejo de errores
  }
}

// Función para obtener las encuestas de un paciente
Future<List<dynamic>> obtenerPreguntasDePaciente(String pacienteId) async {
  try {
    // Obtenemos el documento del paciente
    final pacienteDoc = await FirebaseFirestore.instance.collection('paciente').doc(pacienteId).get();

    // Verificamos si el paciente tiene encuestas asociadas
    if (pacienteDoc.exists && pacienteDoc.data()!.containsKey('encuestasVinculadas')) {
      // Recuperamos las referencias de las encuestas respondidas por el paciente
      final preguntasVinculadas = pacienteDoc['preguntasVinculadas'] as List<dynamic>;

      return preguntasVinculadas;
    } else {
      // El paciente no tiene encuestas asociadas
      return [];
    }
  } catch (e) {
    print('Error al obtener encuestas de paciente: $e');
    // Manejo de errores
    return [];
  }
}

// Función para eliminar una encuesta de un paciente
Future<void> eliminaPreguntasDePaciente(String pacienteId, String preguntaId) async {
  try {
    // Obtenemos la referencia al documento del paciente
    final pacienteRef = FirebaseFirestore.instance.collection('paciente').doc(pacienteId);

    // Actualizamos el documento del paciente para remover la referencia de la encuesta
    await pacienteRef.update({
      'preguntasVinculadas': FieldValue.arrayRemove([preguntaId])
    });
  } catch (e) {
    print('Error al eliminar encuesta del paciente: $e');
    // Manejo de errores
  }
}

Future<void> actualizaEstadoPaciente(String? uid,int estado)async {
  await db.collection('paciente').doc(uid).update({'estado': estado});
}

Future<Paciente?> obtenerPacientePorId(String pacienteId) async {
  try {
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
    await FirebaseFirestore.instance.collection('paciente').doc(pacienteId).get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data()!;
      return Paciente.fromMap(data);
    } else {
      return null;
    }
  } catch (e) {
    // Manejo de errores
    return null;
  }
}