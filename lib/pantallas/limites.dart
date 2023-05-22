import 'package:flutter/material.dart';


class Limites extends StatelessWidget{
  const Limites({Key? key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Limites"),
      ),
      body: Text("Marcar limites"),
    );
  }
}