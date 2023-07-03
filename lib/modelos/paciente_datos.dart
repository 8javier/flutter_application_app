import 'package:flutter_application_app/modelos/profesional_datos.dart';

class Paciente {
  final String? id;
  final String? uid;
  final String? nombre;
  final String? apellido;
  final String? celular;
  final String? dni;
  final String? email;
  final String? rol;
  final List<String>? encuestasVinculadas;
  final List<String>? preguntasVinculadas;
  final int? estado;
  final String? profesional;

  
  Paciente({
    this.id,
    this.uid,
    this.nombre,
    this.apellido,
    this.celular,
    this.dni,
    this.email,
    this.encuestasVinculadas,
    this.preguntasVinculadas,
    this.estado,
    this.rol,
    this.profesional,
  });

  factory Paciente.fromMap(Map<String, dynamic> map) {
    return Paciente(
      id: map['id'],
      uid: map['uid'],
      nombre: map['nombre'],
      apellido: map['apellido'],
      celular: map['celular'],
      dni: map['dni'],
      email: map['email'],
      estado: map['estado'],
      rol: map['rol'],
      profesional: map['profesional']
    );
  }
  Map<String, dynamic> toMap() {// agregar el id para usar en otras funciones!!! q consumen el toMap
    return {
      'nombre': nombre,
      'apellido': apellido,
      'celular': celular,
      'dni': dni,
      'email': email,
      'encuestasVinculadas': encuestasVinculadas,
      'preguntasVinculadas': preguntasVinculadas,
      'rol':rol,
      'id':id,
      'uid':uid,
      'profesional': profesional,
      // Agrega más propiedades si es necesario
    };
  }

String? getName(){
  return nombre;
}

String? getRol(){
  return rol;
}

String? getid(){
  return id;
}

int? getEstado(){
    return estado;
}

String? getProfesional(){
    return profesional;
}

 @override
  String toString() {
    return 'Paciente - Nombre: $nombre, Apellido: $apellido, Celular: $celular, DNI: $dni, Email: $email, Rol: $rol, id: $id';
}
  
}
