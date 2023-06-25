import 'package:flutter/material.dart';
class Boton extends StatelessWidget {
  final Function()? onTap;
  final String texto;
   const Boton({super.key, required this.onTap, required this.texto});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin:const EdgeInsets.symmetric(horizontal: 25) ,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius:BorderRadius.circular(9),
        ),
        child: Center(
          child: Text(
            texto,
             style:const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}