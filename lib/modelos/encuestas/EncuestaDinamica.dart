
import 'Pregunta.dart';

//BORRADOR    Clase para las encuestas dinamicas
class EncuestaDinamica {
  int id;
  List<Pregunta> preguntas;
  int pesoTotal;

  EncuestaDinamica(this.id, this.preguntas, this.pesoTotal);

  // Setter y getter para el ID
  void setId(int id) {
    this.id = id;
  }

  int getId() {
    return id;
  }

  // Setter y getter para la lista de preguntas
  void setPreguntas(List<Pregunta> preguntas) {
    this.preguntas = preguntas;
  }

  List<Pregunta> getPreguntas() {
    return preguntas;
  }

  // Setter y getter para el peso total
  void setPesoTotal(int pesoTotal) {
    this.pesoTotal = pesoTotal;
  }

  int getPesoTotal() {
    return pesoTotal;
  }

  //Funcion para obtener la pregunta dependiendo del pesoTotal que lleve la encuesta
   Pregunta obtenerSiguientePregunta() {
    int inicio = 0;
    int fin = preguntas.length - 1;
    Pregunta? siguientePregunta;

    while (inicio <= fin) {
      int medio = inicio + ((fin - inicio) ~/ 2);
      Pregunta preguntaActual = preguntas[medio];

      if (preguntaActual.peso == pesoTotal) {
        siguientePregunta = preguntaActual;
        break;
      } else if (preguntaActual.peso < pesoTotal) {
        inicio = medio + 1;
      } else {
        fin = medio - 1;
      }
    }
    return siguientePregunta!;
  }

  //funcion para oredenar las preguntas dependiendo de su atributo peso
   void ordenarPreguntasPorPeso() {
    preguntas.sort((a, b) => a.peso.compareTo(b.peso));
  }

  //funcion para sumar el peso de la encuesta con el peso de la opcion elegida en pantalla 
  void sumarPesoOpcion(int pesoOpcion) {
    pesoTotal += pesoOpcion;
  }
}