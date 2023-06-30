class Paciente {
  final String? id;
  final String? uid;
  final String? nombre;
  final String? apellido;
  final String? celular;
  final String? dni;
  final String? email;
   final String? rol;
  
  Paciente({
    this.id,
    this.uid,
    this.nombre,
    this.apellido,
    this.celular,
    this.dni,
    this.email,
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
      rol: map['rol'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'apellido': apellido,
      'celular': celular,
      'dni': dni,
      'email': email,
      'rol':rol,
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
    return 'Paciente - Nombre: $nombre, Apellido: $apellido, Celular: $celular, DNI: $dni, Email: $email, Rol: $rol';
}
  
}
