import 'package:flutter/material.dart';

class NavegarBoton extends StatelessWidget {
  final String texto;
  final Widget paginaDestino;

  NavegarBoton({required this.texto, required this.paginaDestino});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => paginaDestino),
        );
      },
      child: Text(texto),
    );
  }
}
