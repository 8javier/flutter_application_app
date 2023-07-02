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
      encuestasVinculadas: map['encuestasVinculadas'],
      preguntasVinculadas: map['preguntasVinculadas'],
      estado: map['estado'],
      rol: map['rol'],
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
 @override
  String toString() {
    return 'Paciente - Nombre: $nombre, Apellido: $apellido, Celular: $celular, DNI: $dni, Email: $email, Rol: $rol, id: $id';
}
  
}
