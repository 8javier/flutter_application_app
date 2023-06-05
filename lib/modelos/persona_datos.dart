
import 'chat_mensaje.dart';

class Paciente {
  String?  nombre;
  String?  apellido;
  int? edad;
  String?  telefono;
  String?  email;
  List<Mensaje>?  mensajes;
  String? imagenUrl;
  String? audioUrl;

  Paciente({this.nombre, this.apellido,this.edad,this.telefono,this.email,this.mensajes,this.audioUrl,this.imagenUrl});
}
