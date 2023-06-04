import 'package:flutter/material.dart';

import '../reciclar/textfield.dart';

class QuizPaciente extends StatefulWidget {
  const QuizPaciente({super.key});

  @override
  State<QuizPaciente> createState() => _QuizPacienteState();
}

class _QuizPacienteState extends State<QuizPaciente> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(padding: const EdgeInsets.all(20),
        child: Text("Question",
        style: TextStyle(fontSize: 25),),
        ),
        Padding(padding: const EdgeInsets.all(20),
        child:texto(20) ,),
        IconButton(onPressed: (){}, icon: Icon(Icons.send))
      ],
    );
  }
}