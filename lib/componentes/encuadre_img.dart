import 'package:flutter/material.dart';

class EncuadreImg extends StatelessWidget {
  final Function()? onTap;
  final String imagenesPath;
  const EncuadreImg({super.key, required this.imagenesPath,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:  const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.deepPurple),
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromARGB(255, 197, 149, 164),
          ),
        child: Image.asset(
          imagenesPath,
          height: 40,
        ),
      ),
    );
  }
}
