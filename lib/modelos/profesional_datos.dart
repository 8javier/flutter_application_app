
import 'package:flutter_application_app/modelos/rolUsuarios.dart';

import 'paciente_datos.dart';

class Profesional {
    final String? id;
    final String? uid;
    final String? nombre;
    final String? apellido;
    final String? celular;
    final String? dni;
    final String? email;
    final String? rol;
    List<Paciente>? pacientes;
    List<String>? encuestasCargadas;
    List<String>? preguntasCargadas;

    Profesional({
        this.email,
        this.id,
        this.uid,
        this.nombre,
        this.apellido,
        this.celular,
        this.dni,
        this.rol,
        this.encuestasCargadas,
        this.preguntasCargadas,
        this.pacientes,
    });

    /*factory Profesional.fromJson(Map<String, dynamic> json) => Profesional(

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
    };*/

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
            pacientes: [],
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
