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
                 padding: const EdgeInsets.symmetric(horizontal: 66.0),
                 child: TextField(
                  controller: controller,
                  obscureText: textObscuro,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                       focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: hinttext,
                             ),
                             ),
               );

  }
}