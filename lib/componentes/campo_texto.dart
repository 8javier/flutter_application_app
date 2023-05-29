import 'package:flutter/material.dart';

class CampoTexto extends StatelessWidget {
final controller;   // <-- captura lo q el usuario escribe
final String hinttext; // <-- string para controlar lo q el usuario escribe
final bool textObscuro;

  const CampoTexto({
    super.key, 
    required this.controller, 
    required this.hinttext, 
    required this.textObscuro
    });

  @override
  Widget build(BuildContext context) {
    return  Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 116.10),
                 child: TextField(
                  controller: controller,
                  obscureText: textObscuro,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 135, 172, 228)),
                      ),
                       focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 219, 18, 51)),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: hinttext,
                             ),
                             ),
               );

  }
}