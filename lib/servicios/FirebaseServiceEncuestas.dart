import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_app/modelos/encuestas/preguntaDinamica.dart';
import '../modelos/encuestas/EncuestasDinamica.dart';

class EncuestaService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String encuestasCollection = 'encuestas';
  final String preguntasCollection = 'preguntas';

  Future<void> guardarEncuestaDinamica(EncuestaDinamica encuesta) async {
    try {
      await firestore
          .collection(encuestasCollection)
          .doc(encuesta.id)
          .set(encuesta.toJson());
    } catch (e) {
      // Manejo de errores
    }
  }

  Future<List<EncuestaDinamica>> obtenerEncuestas() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
      await firestore.collection(encuestasCollection).get();

      List<EncuestaDinamica>? encuestas = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        return EncuestaDinamica.fromData(data);
      }).toList();

      return encuestas;
    } catch (e) {
      // Manejo de errores
      return [];
    }
  }

  Future<EncuestaDinamica?> obtenerEncuestaPorId(String encuestaId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
      await firestore.collection(encuestasCollection).doc(encuestaId).get();

      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()!;
        return EncuestaDinamica.fromData(data);
      } else {
        return null;
      }
    } catch (e) {
      // Manejo de errores
      return null;
    }
  }

  Future<void> guardarPreguntaDinamica(PreguntaDinamica pregunta) async {
    try {
      await firestore
          .collection(preguntasCollection)
          .doc(pregunta.id)
          .set(pregunta.toJson());
    } catch (e) {
      // Manejo de errores
    }
  }

  Future<List<PreguntaDinamica>> obtenerPreguntas() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
      await firestore.collection(preguntasCollection).get();

      List<PreguntaDinamica>? preguntas = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        return PreguntaDinamica.fromData(data);
      }).toList();

      return preguntas;
    } catch (e) {
      // Manejo de errores
      return [];
    }
  }

  Future<PreguntaDinamica?> obtenerPreguntasPorId(String preguntaId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
      await firestore.collection(preguntasCollection).doc(preguntaId).get();

      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()!;
        return PreguntaDinamica.fromData(data);
      } else {
        return null;
      }
    } catch (e) {
      // Manejo de errores
      return null;
    }
  }
}