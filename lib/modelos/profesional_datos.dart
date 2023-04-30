
class Profesional {

    String nombre;
    String apellido;
    String celular;
    String dni;
    String matricula;

    Profesional({

        required this.nombre,
        required this.apellido,
        required this.celular,
        required this.dni,
        required this.matricula,
    });

    factory Profesional.fromJson(Map<String, dynamic> json) => Profesional(

        nombre: json["nombre"],
        apellido: json["apellido"],
        celular: json["celular"],
        dni: json["dni"],
        matricula: json["matricula"],
    );

    Map<String, dynamic> toJson() => {
      
        "nombre": nombre,
        "apellido": apellido,
        "celular": celular,
        "dni": dni,
        "matricula": matricula,
    };
}
