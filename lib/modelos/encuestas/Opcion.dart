
//BORRADOR    Clase para las opciones de las preguntas
class Opcion {
  String id;
  int peso;
  String texto;

  Opcion(this.id, this.peso, this.texto);

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

  // Setter y getter para el texto de opción
  void setTexto(String texto) {
    this.texto = texto;
  }

  String getTexto() {
    return texto;
  }
}