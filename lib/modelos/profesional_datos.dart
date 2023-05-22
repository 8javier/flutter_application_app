
import 'package:flutter_application_app/modelos/rolUsuarios.dart';

class Profesional {

    String nombre;
    String apellido;
    String celular;
    String dni;
    String matricula;
      RolUsuario rol;
    Profesional({

        required this.nombre,
        required this.apellido,
        required this.celular,
        required this.dni,
        required this.matricula,
        required this.rol,
    });

    factory Profesional.fromJson(Map<String, dynamic> json) => Profesional(

        nombre: json["nombre"],
        apellido: json["apellido"],
        celular: json["celular"],
        dni: json["dni"],
        matricula: json["matricula"],
        rol: json["rol"],
      
    );

    Map<String, dynamic> toJson() => {
      
        "nombre": nombre,
        "apellido": apellido,
        "celular": celular,
        "dni": dni,
        "matricula": matricula,
        "rol":rol,   
    };

}
