import 'dart:html';

import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawerpaciente(context),
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: ListView(children: <Widget>[
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 5, left: 10),
              decoration: BoxDecoration(
                  color: Color(0xff838282),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10))),
              height: 75,
              padding: const EdgeInsets.all(10),
              width: 350,
              child: Text(
                "Progreso",
              ),
            ), if(!alerta) 
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 5, right: 10),
              decoration: BoxDecoration(
                  color: Color(0x11838282),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              height: 75,
              width: 40,
              child: IconButton(
                  onPressed: () {
                    showDialog(
            context: context, 
            builder: (_)=> new AlertDialog(
              title: Text("[Proximamente...]"),
            ));
                    /* Navigator.pushNamed(context, '/limites'); */
                  }, icon: Icon(Icons.error_outline_sharp)),
            )
          ],
        ),
        Row(
          children: [
            InkWell(
              child:
            Container(
              margin:
                  const EdgeInsets.only(top: 5, bottom: 5, right: 5, left: 10),
              height: 75,
              width: 190,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Color(0x11838282),
                  borderRadius: BorderRadius.circular(10)),
              child: Text("Estado físico"),
            ),
            onTap: () {
              showDialog(
            context: context, 
            builder: (_)=> new AlertDialog(
              title: Text("[Proximamente...]"),
            ));
            },
            ),
            InkWell(
              child: Container(
              margin:
                  const EdgeInsets.only(top: 5, bottom: 5, right: 10, left: 5),
              height: 75,
              width: 190,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Color(0x11838282),
                  borderRadius: BorderRadius.circular(10)),
              child: Text("Links"),
            ),
            onTap: () {
              showDialog(
            context: context, 
            builder: (_)=> new AlertDialog(
              title: Text("[Proximamente...]"),
            ));
            },
            )
            
          ],
        ),InkWell(
          child: Container(
          
          margin: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
          height: 75,
          width: 400,
          padding: const EdgeInsets.all(10),
          child: Text("Recomendaciones"),
          decoration: BoxDecoration(
              color: Color(0xff636262),
              borderRadius: BorderRadius.circular(10)),
        ),
        onTap: (){
          showDialog(
            context: context, 
            builder: (_)=> new AlertDialog(
              title: Text("[Proximamente...]"),
            ));
        },
        )
        ,
        Container(
          margin:
              const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 5),
          height: 300,
          width: 300,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Color(0x33838282),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Title(
                child: Text("Diario"),
                color: Color(0xff000000),
              ),
              Center(child: Icon(Icons.draw_outlined)),
              texto()
            ],
          ),
        )
      ]),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          if(alerta)
          BottomNavigationBarItem(
              icon: Badge(
                child: estado(context),
              ),
              label: "Estado")
              else
                BottomNavigationBarItem(
              icon: 
                estado(context),
              label: "Estado"),
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
