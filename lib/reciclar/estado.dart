import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Widget estado(contexto) {

  String traerUsuario() {
    String user_id = FirebaseAuth.instance.currentUser!.uid;
    return user_id;
  }

  void cargarFeliz() {
    var user_id = traerUsuario();

  }

  void cargarNeutral() {
    var user_id = traerUsuario();

  }

  void cargarMal() {
    var user_id = traerUsuario();

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
                                cargarFeliz();
                                Navigator.pop(contexto);
                              },
                              icon: Icon(Icons.heart_broken_outlined ),
                              iconSize: 50,
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.pop(contexto);
                              },
                              icon: Icon(Icons.mood_bad),
                              iconSize: 50,
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.pop(contexto);
                              },
                              icon: Icon(Icons.tag_faces_sharp),
                              iconSize: 50,
                            ),
                            IconButton(
                              onPressed: () {
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