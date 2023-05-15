import 'package:flutter/material.dart';


class Recommend extends StatelessWidget{
  const Recommend({Key? key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recomendaciones"),
      ),
      body: Text("Escribir recomendaciones y sus checks"),
    );
  }
}