import 'package:flutter/material.dart';

Widget estado(contexto) {
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
                                Navigator.pop(contexto);
                              },
                              icon: Icon(Icons.tag_faces_sharp),
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
                              icon: Icon(Icons.tag_faces_sharp),
                              iconSize: 50,
                            ),
                          ],
                        )
                      ],
                    ))
          },
      icon: Icon(Icons.tag_faces_outlined));
}