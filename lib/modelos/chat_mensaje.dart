class Mensaje {
  String? remitente;
  String? destinatario;
  String? contenido;
  String? tipo; // Puede ser "texto", "audio", "imagen", etc.

  Mensaje({this.remitente, this.destinatario, this.contenido, this.tipo});
}
