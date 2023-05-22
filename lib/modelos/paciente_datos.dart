

import 'package:flutter_application_app/modelos/rolUsuarios.dart';

class Paciente {
    
    String nombre;
    String apellido;
    String celular;
    String dni;
    RolUsuario rol;

    Paciente({
      
        required this.nombre,
        required this.apellido,
        required this.celular,
        required this.dni,
        required this.rol,
    });
    factory Paciente.fromJson(Map<String, dynamic> json) => Paciente(
      
        nombre: json["nombre"],
        apellido: json["apellido"],
        celular: json["celular"],
        dni: json["dni"], 
        rol: json["rol"],
      
       
    );

    Map<String, dynamic> toJson() => {
        
        "nombre": nombre,
        "apellido": apellido,
        "celular": celular,
        "dni": dni,
        "rol":rol,      
    };
}


