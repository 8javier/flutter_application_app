import 'Opcion.dart';

//BORRADOR      Clase para las preguntas de las encuestas
class Pregunta {
  int id;
  int peso;
  String texto;
  List<Opcion> opciones;
  bool esFinal;

  Pregunta(this.id, this.peso, this.texto, this.opciones, this.esFinal);

  // Setter y getter para el ID
  void setId(int id) {
    this.id = id;
  }

  int getId() {
    return id;
  }

  // Setter y getter para el peso
  void setPeso(int peso) {
    this.peso = peso;
  }

  int getPeso() {
    return peso;
  }

  // Setter y getter para el texto de la pregunta
  void setTexto(String texto) {
    this.texto = texto;
  }

  String getTexto() {
    return texto;
  }

  // Setter y getter para la lista de opciones
  void setOpciones(List<Opcion> opciones) {
    this.opciones = opciones;
  }

  List<Opcion> getOpciones() {
    return opciones;
  }

  // Setter y getter para esFinal
  void setFinal(bool newfinal) {
    esFinal = newfinal;
  }

  bool getFinal() {
    return esFinal;
  }
  
  //funcion para obtener el peso de una opcion
  int obtenerPesoOpcion(int opcionId) {
    Opcion opcionEncontrada =
        opciones.firstWhere((opcion) => opcion.getId() == opcionId, orElse: () => Opcion(-1, 0, ''));
    return opcionEncontrada.getPeso();
  }
}