import 'package:cloud_firestore/cloud_firestore.dart';

import '../modelos/encuestas/EncuestaDinamica.dart';
import '../modelos/encuestas/Opcion.dart';
import '../modelos/encuestas/Pregunta.dart';

// funciones para la administracion en firebase

FirebaseFirestore db = FirebaseFirestore.instance;

//BORRADOR     Funcion para traer las encuestas dinamicas
/*Future<List<EncuestaDinamica>> obtenerEncuestas() async {
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
  }*/