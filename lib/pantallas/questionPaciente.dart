import 'package:flutter/material.dart';
import 'package:flutter_application_app/reciclar/textfield.dart';

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