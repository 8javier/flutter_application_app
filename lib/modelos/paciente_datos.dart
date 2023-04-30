

class Paciente {
    
    String nombre;
    String apellido;
    String celular;
    String dni;
  

    Paciente({
      
        required this.nombre,
        required this.apellido,
        required this.celular,
        required this.dni,
       
    });

    factory Paciente.fromJson(Map<String, dynamic> json) => Paciente(
      
        nombre: json["nombre"],
        apellido: json["apellido"],
        celular: json["celular"],
        dni: json["dni"],
       
    );

    Map<String, dynamic> toJson() => {
        
        "nombre": nombre,
        "apellido": apellido,
        "celular": celular,
        "dni": dni,
      
    };
}
