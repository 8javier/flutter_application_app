import 'Opcion.dart';

class Pregunta {
  String id;
  int peso;
  String texto;
  List<Opcion> opciones;
  bool esFinal;

  Pregunta({
    required this.id,
    required this.peso,
    required this.texto,
    required this.opciones,
    required this.esFinal});

  // Setter y getter para el ID
  void setId(String id) {
    this.id = id;
  }

  String getId() {
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
    opciones.firstWhere((opcion) => opcion.getId() == opcionId);
    return opcionEncontrada.getPeso();
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> opcionesJson = opciones.map((opcion) =>
        opcion.toJson()).toList();

    return {
      'id': id,
      'texto': texto,
      'peso': peso,
      'opciones': opcionesJson,
      'esFinal': esFinal,
    };
  }

  factory Pregunta.fromData(Map<String, dynamic> data) {
    List<dynamic> opcionesData = data['opciones'];

    List<Opcion> opciones = opcionesData.map((opcionData) {
      return Opcion.fromData(opcionData);
    }).toList();

    return Pregunta(
      id: data['id'],
      texto: data['texto'],
      peso: data['peso'],
      opciones: opciones,
      esFinal: data['esFinal'],
    );
  }
}