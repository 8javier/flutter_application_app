
import 'package:flutter/material.dart';
import 'package:flutter_application_app/pantallas/mainPaciente.dart';
import 'package:flutter_application_app/pantallas/questionPaciente.dart';
import 'package:flutter_application_app/pantallas/quizPaciente.dart';
import 'package:flutter_application_app/reciclar/drawerpaciente.dart';
import 'package:flutter_application_app/reciclar/estado.dart';
import 'package:flutter_application_app/reciclar/textfield.dart';

class HomePaciente extends StatefulWidget {
  const HomePaciente({super.key});

  @override
  State<HomePaciente> createState() => _HomePacienteState();
}

class _HomePacienteState extends State<HomePaciente> {
  var alerta = false;
  var page = 0;

  List<Widget> pages = [
    MainPaciente(),
    QuestionPaciente(),
    QuizPaciente()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawerpaciente(context),
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: pages[page],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          setState(() {
            page = index;
          });
        },


        currentIndex: page,
        items: [
          if(alerta)
          BottomNavigationBarItem(
              icon: Badge(
                child: Icon(Icons.home)
              ),
              label: "Home")
              else
                BottomNavigationBarItem(
              icon: 
                Icon(Icons.home),
              label: "Home"),
              if(alerta)
                BottomNavigationBarItem(
                icon: Badge(child: Icon(Icons.question_mark_outlined),), label: "Pregunta")
              else
                BottomNavigationBarItem(
                icon: Icon(Icons.question_mark_outlined), label: "Pregunta"),
              if(alerta)
                BottomNavigationBarItem(
                icon: Badge(child: Icon(Icons.checklist_sharp),), label: "Cuestionario")
              else
                BottomNavigationBarItem(
                icon: Icon(Icons.checklist_sharp), label: "Cuestionario")          
        ],
      ),
    );
  }
}
