import 'package:flutter/material.dart';

class QuestionPaciente extends StatefulWidget {
  const QuestionPaciente({super.key});

  @override
  State<QuestionPaciente> createState() => _QuestionPacienteState();
}

class _QuestionPacienteState extends State<QuestionPaciente> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Text("Question")
      ],
    );
  }
}