class Profesional {
  final String? id;
  final String? uid;
  final String? nombre;
  final String? apellido;
  final String? celular;
  final String? dni;
  final String? email;
   final String? rol;
  
  Profesional({
    this.id,
    this.uid,
    this.nombre,
    this.apellido,
    this.celular,
    this.dni,
    this.email,
    this.rol,
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

String? getId(){
  return id;
}

}
