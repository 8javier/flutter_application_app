import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_app/servicios/firebase_service.dart';

import '../modelos/paciente_datos.dart';

Widget estado(contexto) {

  Future<Paciente?> traerUsuario() async {
    String user_id = FirebaseAuth.instance.currentUser!.uid;
    Paciente? paciente = await obtenerPacientePorId(user_id);
    return paciente;

  }

  Future<void> cargarFeliz() async {
    var paciente = await traerUsuario();
    var estado = paciente?.getEstado();
    actualizaEstadoPaciente(paciente?.getid(), estado! - 1000);
  }

  Future<void> cargarMuyFeliz() async {
    var paciente = await traerUsuario();
    var estado = paciente?.getEstado();
    actualizaEstadoPaciente(paciente?.getid(), estado! - 1500);
  }

  Future<void> cargarMal() async {
    var paciente = await traerUsuario();
    var estado = paciente?.getEstado();
    actualizaEstadoPaciente(paciente?.getid(), estado! + 1000);
  }

  Future<void> cargarMuyMal() async {
    var paciente = await traerUsuario();
    var estado = paciente?.getEstado();
    actualizaEstadoPaciente(paciente?.getid(), estado! + 1500);
  }


  return IconButton(
      onPressed: () => {
            showDialog(
                context: contexto,
                builder: (_) => new AlertDialog(
                      title: Text("¿Cómo te sientes hoy?"),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              onPressed: () {
                                cargarMuyMal();
                                Navigator.pop(contexto);
                              },
                              icon: Icon(Icons.heart_broken_outlined ),
                              iconSize: 50,
                            ),
                            IconButton(
                              onPressed: () {
                                cargarMal();
                                Navigator.pop(contexto);
                              },
                              icon: Icon(Icons.mood_bad),
                              iconSize: 50,
                            ),
                            IconButton(
                              onPressed: () {
                                cargarFeliz();
                                Navigator.pop(contexto);
                              },
                              icon: Icon(Icons.tag_faces_sharp),
                              iconSize: 50,
                            ),
                            IconButton(
                              onPressed: () {
                                cargarMuyFeliz();
                                Navigator.pop(contexto);
                              },
                              icon: Icon(Icons.favorite_border),
                              iconSize: 50,
                            ),
                          ],
                        )
                      ],
                    ))
          },
      icon: Icon(Icons.tag_faces_outlined));

}