import 'Opcion.dart';

class Pregunta {
  String enunciado;
  List<Opcion> opciones;
  Pregunta? si;
  Pregunta? no;

  Pregunta({required this.enunciado, required this.opciones, this.si, this.no});
  
  Pregunta obtenerSiguientePregunta(List<int> respuestas) {
    // Obtener la respuesta dada por el usuario a esta pregunta
    int respuesta = respuestas.last;

    // Según la respuesta dada, retornar la siguiente pregunta
    if (respuesta == 0) {
      // Si la respuesta es "no", retornar la pregunta "no" si existe, o la siguiente pregunta por defecto
      return no ?? si!;
    } else {
      // Si la respuesta es "sí", retornar la pregunta "sí" si existe, o la siguiente pregunta por defecto
      return si ?? no!;
    }
  }
}