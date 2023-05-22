import 'package:flutter/material.dart';


class Recommend extends StatelessWidget{
  const Recommend({Key? key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recomendaciones"),
      ),
      body: ListView(
        children: <Widget>[
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
        ),
          Text("Escribir recomendaciones y sus checks"),
        ],)
    );
  }
}