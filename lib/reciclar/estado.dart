import 'package:flutter/material.dart';

Widget estado(contexto) {
  return IconButton(
    onPressed: () {
      Navigator.pop(contexto);
    },
    icon: Icon(Icons.tag_faces_sharp),
    iconSize: 50,
  );
}
