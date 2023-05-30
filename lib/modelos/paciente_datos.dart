class Paciente {
  String id;
  String uid;
  String nombre;
  String apellido;
  String celular;
  String dni;
  String email;

  Paciente({
    required this.id,
    required this.uid,
    required this.nombre,
    required this.apellido,
    required this.celular,
    required this.dni,
    required this.email,
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
    );
  }
}
