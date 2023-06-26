class Paciente {
  final String? id;
  final String? uid;
  final String? nombre;
  final String? apellido;
  final String? celular;
  final String? dni;
  final String? email;
  final List<String>? encuestasVinculadas;
  final List<String>? preguntasVinculadas;
  
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
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'apellido': apellido,
      'celular': celular,
      'dni': dni,
      'email': email,
      'encuestasVinculadas': encuestasVinculadas,
      'preguntasVinculadas': preguntasVinculadas,
      // Agrega más propiedades si es necesario
    };
  }

String? getName(){
  return nombre;
}


}
