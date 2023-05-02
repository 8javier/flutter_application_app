import 'package:flutter/material.dart';
class Boton extends StatelessWidget {
   const Boton({super.key, required this.onTap});

final Function()? onTap;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        
      },
      child: Container(
        padding: const EdgeInsets.all(25),
        margin:const EdgeInsets.symmetric(horizontal: 25) ,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius:BorderRadius.circular(9),
        ),
        child: const Center(
          child: Text('Sign in',
          style: TextStyle(
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