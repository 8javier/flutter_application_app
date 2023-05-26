import 'package:flutter/material.dart';
import 'package:flutter_application_app/reciclar/estado.dart';

import '../reciclar/textfield.dart';

class MainPaciente extends StatefulWidget {
  const MainPaciente({super.key});

  @override
  State<MainPaciente> createState() => _MainPacienteState();
}

class _MainPacienteState extends State<MainPaciente> {

  var alerta = false;
  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
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
          Navigator.pushNamed(context, '/recommend');
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
              color: Color(0xff838282),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Title(
                child: Text("Diario"),
                color: Color(0xffffffff),
              ),
              Center(child: Icon(Icons.draw_outlined)),
              texto(10)
            ],
          ),
        ),
        IconButton(
          onPressed: () => {
            showDialog(
              context: context,
              builder: (_) => new AlertDialog(
                title: Text("¿Cómo te sientes hoy?"),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      estado(context),
                      estado(context),
                      estado(context)
                    ],
                  )
                ],
              )
              )
          }, 
          icon: Icon(Icons.tag_faces_outlined))
      ]);
  }
}