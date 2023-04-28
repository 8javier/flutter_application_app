
import 'Pregunta.dart';

//BORRADOR    Clase para las encuestas dinamicas
class EncuestaDinamica {
  String titulo;
  String descripcion;
  Pregunta raiz;

  EncuestaDinamica({
    required this.titulo,
    required this.descripcion,
    required this.raiz,
  });

  Pregunta obtenerSiguientePregunta(Pregunta preguntaActual, List<int> respuestas) {
    return preguntaActual.obtenerSiguientePregunta(respuestas);
  }
}