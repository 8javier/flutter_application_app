import 'paciente_datos.dart';

import 'paciente_datos.dart';

class Profesional {
  final String? id;
  final String? uid;
  final String? nombre;
  final String? apellido;
  final String? celular;
  final String? dni;
  final String? email;
  final String? rol;
  List<Paciente>? pacientes;
  List<String>? encuestasCargadas;
  List<String>? preguntasCargadas;

  Profesional({
    this.email,
    this.id,
    this.uid,
    this.nombre,
    this.apellido,
    this.celular,
    this.dni,
    this.rol,
    this.encuestasCargadas,
    this.preguntasCargadas,
    this.pacientes,
  });

  factory Profesional.fromMap(Map<String, dynamic> map) {
    return Profesional(
      id: map['id'],
      uid: map['uid'],
      nombre: map['nombre'],
      apellido: map['apellido'],
      celular: map['celular'],
      dni: map['dni'],
      email: map['email'],
      rol: map['rol'],
      pacientes: [],
      encuestasCargadas: map['encuestasCargadas'],
      preguntasCargadas: map['preguntasCargadas'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'nombre': nombre,
      'apellido': apellido,
      'celular': celular,
      'dni': dni,
      'email': email,
      'rol':rol,
      'encuestasCargadas': encuestasCargadas,
      'preguntasCargadas': preguntasCargadas,
      // Agrega más propiedades si es necesario
    };
  }

  String? getName(){
    return nombre;
  }
  String? getRol(){
    return rol;
  }

  String? getId(){
    return id;
  }
}
