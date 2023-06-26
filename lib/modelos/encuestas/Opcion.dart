class Opcion {
  String id;
  int peso;
  String texto;

  Opcion({
      required this.id,
      required this.peso,
      required this.texto});

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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'peso': peso,
      'texto': texto,
    };
  }

  factory Opcion.fromData(Map<String, dynamic> data) {
    return Opcion(
      id: data['id'],
      texto: data['texto'],
      peso: data['peso'],
    );
  }
}