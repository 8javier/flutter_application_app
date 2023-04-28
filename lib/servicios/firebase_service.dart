import 'package:cloud_firestore/cloud_firestore.dart';

import '../modelos/encuestas/EncuestaDinamica.dart';
import '../modelos/encuestas/EncuestaEstatica.dart';
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

//BORRADOR     Funcion para traer las encuestas dinamicas
Future<List<EncuestaDinamica>> obtenerEncuestas() async {
  List<EncuestaDinamica> encuestas = [];

  try {
    QuerySnapshot querySnapshot = await db.collection('encuestas').get();

    for (QueryDocumentSnapshot document in querySnapshot.docs) {
      EncuestaDinamica encuesta = EncuestaDinamica(
        titulo: document['titulo'],
        descripcion: document['descripcion'],
        raiz: await _obtenerPregunta(document['raiz']),
      );

      encuestas.add(encuesta);
    }
  } catch (e) {
    print(e.toString());
  }

  return encuestas;
}

//BORRADOR   funcion paraa trar las preguntas de las encuestas dinamicas
Future<Pregunta> _obtenerPregunta(DocumentReference preguntaRef) async {
    DocumentSnapshot preguntaSnapshot = await preguntaRef.get();

    Pregunta pregunta = Pregunta(
      enunciado: preguntaSnapshot.get('enunciado'),
      opciones: (preguntaSnapshot.get('opciones') as List<dynamic>)
          .map((opcionData) => Opcion(texto: opcionData['texto'], esCorrecta: opcionData['esCorrecta']))
          .toList(),
    );

    DocumentReference siRef = preguntaSnapshot.get('si');
    DocumentReference noRef = preguntaSnapshot.get('no');

    if (siRef != null) {
      pregunta.si = await _obtenerPregunta(siRef);
    }

    if (noRef != null) {
      pregunta.no = await _obtenerPregunta(noRef);
    }

    return pregunta;
  }
//BORRADOR    funcion para obtener las diferentes opciones de las preguntas
List<Opcion> _obtenerOpciones(List<dynamic> opciones) {
  List<Opcion> listaOpciones = [];

  opciones.forEach((opcion) {
    listaOpciones.add(opcion(
      texto: opcion['texto'],
      esCorrecta: opcion['esCorrecta'],
    ));
  });

  return listaOpciones;
}
//BORRADOR   funcion para traer las encuestas estaticas
 Future<List<EncuestaEstatica>> buscarEncuestasEstaticas() async {
    List<EncuestaEstatica> encuestasEstaticas = [];

    QuerySnapshot encuestasSnapshot = await db.collection('encuestasEstaticas').get();

    for (DocumentSnapshot encuestaSnapshot in encuestasSnapshot.docs) {
      EncuestaEstatica encuesta = EncuestaEstatica(
        titulo: encuestaSnapshot.get('titulo'),
        descripcion: encuestaSnapshot.get('descripcion'),
        preguntas: (encuestaSnapshot.get('preguntas') as List<dynamic>)
            .map((preguntaData) => Pregunta(
                  enunciado: preguntaData['enunciado'],
                  opciones: (preguntaData['opciones'] as List<dynamic>)
                      .map((opcionData) => Opcion(texto: opcionData['texto'], esCorrecta: opcionData['esCorrecta']))
                      .toList(),
                ))
            .toList(),
      );

      encuestasEstaticas.add(encuesta);
    }

    return encuestasEstaticas;
  }