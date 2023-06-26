
import 'package:flutter_application_app/modelos/rolUsuarios.dart';

class Profesional {

    String nombre;
    String apellido;
    String celular;
    String dni;
    String matricula;
    RolUsuario rol;
    List<String>? encuestasCargadas;
    List<String>? preguntasCargadas;

    Profesional({

        required this.nombre,
        required this.apellido,
        required this.celular,
        required this.dni,
        required this.matricula,
        required this.rol,
        this.encuestasCargadas,
        this.preguntasCargadas,
    });

    factory Profesional.fromJson(Map<String, dynamic> json) => Profesional(

        nombre: json["nombre"],
        apellido: json["apellido"],
        celular: json["celular"],
        dni: json["dni"],
        matricula: json["matricula"],
        rol: json["rol"],
        encuestasCargadas: json["encuestasCargadas"],
        preguntasCargadas: json["preguntasCargadas"]
    );

    Map<String, dynamic> toJson() => {
      
        "nombre": nombre,
        "apellido": apellido,
        "celular": celular,
        "dni": dni,
        "matricula": matricula,
        "rol":rol,
        "encuestasCargadas": encuestasCargadas,
        "preguntasCargadas": preguntasCargadas,
    };
}
