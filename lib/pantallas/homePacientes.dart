import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_app/componentes/botonNavegapaginas.dart';
import 'package:flutter_application_app/pantallas/home_inicio.dart';
import 'package:flutter_application_app/pantallas/questionPaciente.dart';
import 'package:flutter_application_app/pantallas/quizPaciente.dart';
import 'package:flutter_application_app/reciclar/drawerpaciente.dart';

import '../modelos/paciente_datos.dart';
import 'mainPaciente.dart';

class HomePaciente extends StatefulWidget {
  const HomePaciente({super.key});

  @override
  State<HomePaciente> createState() => _HomePacienteState();
}

class _HomePacienteState extends State<HomePaciente> {
  var alerta = false;
  var page = 0;
  List<Widget> pages = [
    const MainPaciente(),
    const QuestionPaciente(),
    const QuizPaciente(),
  ];
 // --------------------------------------------- Funciones ------->
   User? currentUser;
   String pacienteId = '';

  // ---
    Future<void> loadCurrentUser() async {  // --
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      currentUser = user;
      if (currentUser != null) {
        pacienteId = currentUser!.uid;
        // Use pacienteId in your functions or actions
        // For example, load specific patient data
        Paciente? pacienteEspecifico = cargarPacienteEspecifico(pacienteId);
        // ...
        
      }
    });
  }
 
    @override
  void initState() {
    super.initState();
    loadCurrentUser(); 
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      drawer: drawerpaciente(context),
      appBar: AppBar(
        title:  Text("Home  ${currentUser!.email}"),
        actions:[ NavegarBoton(texto: 'volver', paginaDestino: HomeInicio())],
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
          const BottomNavigationBarItem(
              icon: Badge(
                child: Icon(Icons.home)
              ),
              label: "Home")
              else
                const BottomNavigationBarItem(
              icon: 
                Icon(Icons.home),
              label: "Home"),
              if(alerta)
                const BottomNavigationBarItem(
                icon: Badge(child: Icon(Icons.question_mark_outlined),), label: "Pregunta")
              else
                const BottomNavigationBarItem(
                icon: Icon(Icons.question_mark_outlined), label: "Pregunta"),
              if(alerta)
                const BottomNavigationBarItem(
                icon: Badge(child: Icon(Icons.checklist_sharp),), label: "Cuestionario")
              else
                const BottomNavigationBarItem(
                icon: Icon(Icons.checklist_sharp), label: "Cuestionario")          
        ],
      ),
    );
  }
}