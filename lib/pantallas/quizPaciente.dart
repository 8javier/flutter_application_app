import 'package:flutter/material.dart';

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
        Text("Quiz")
      ],
    );
  }
}