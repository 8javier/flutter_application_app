import 'package:flutter/material.dart';

class HomePaciente extends StatefulWidget {
  const HomePaciente({super.key});

  @override
  State<HomePaciente> createState() => _HomePacienteState();
}

class _HomePacienteState extends State<HomePaciente> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          child: Column(
            children: [
              Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(top: 50, bottom: 20),
                  child: Icon(
                    Icons.account_circle_outlined,
                    size: 100,
                  )),
              const Text(
                "Nombre Paciente",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Color(0x11838282),
                    borderRadius: BorderRadius.circular(10)),
                height: 50,
                padding: const EdgeInsets.all(10),
                width: 350,
                child: Text(
                  "Notificaciones",
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Color(0x11838282),
                    borderRadius: BorderRadius.circular(10)),
                height: 50,
                padding: const EdgeInsets.all(12),
                width: 350,
                child: Text(
                  "Historial",
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Color(0x11838282),
                    borderRadius: BorderRadius.circular(10)),
                height: 50,
                padding: const EdgeInsets.all(10),
                width: 350,
                child: Text(
                  "datos del usuario",
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Color(0x11838282),
                    borderRadius: BorderRadius.circular(10)),
                height: 50,
                padding: const EdgeInsets.all(10),
                width: 350,
                child: Text(
                  "cerrar sesión",
                ),
              ),
            InkWell(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color(0x11838282),
                      borderRadius: BorderRadius.circular(10)),
                  height: 50,
                  padding: const EdgeInsets.all(10),
                  width: 350,
                  child: Text(
                    "view",
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/view');
                },
              ),
            ],
          ),
        ),
      ),
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
            ),
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
                  onPressed: () {}, icon: Icon(Icons.error_outline_sharp)),
            )
          ],
        ),
        Row(
          children: [
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
            Container(
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
              title: Text("[Aqui se deberia desplegar para ver todas las recomendaciones]"),
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
              TextFormField(
                maxLines: 10,
                decoration: InputDecoration(
                  isDense: true,
                  hintStyle:
                      TextStyle(letterSpacing: 2, color: Color(0xff000000)),
                  fillColor: Color(0xffffffff),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  filled: false,
                  /* icon: Icon(Icons.draw_outlined), */
                ),
              )
            ],
          ),
        )
      ]),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: IconButton(
                  onPressed: () => {
                        showDialog(
                            context: context,
                            builder: (_) => new AlertDialog(
                                  title: Text("¿Cómo te sientes hoy?"),
                                  actions: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: Icon(Icons.tag_faces_sharp),
                                          iconSize: 50,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: Icon(Icons.tag_faces_sharp),
                                          iconSize: 50,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: Icon(Icons.tag_faces_sharp),
                                          iconSize: 50,
                                        ),
                                      ],
                                    )
                                  ],
                                ))
                      },
                  icon: Icon(Icons.tag_faces_outlined)),
              label: "Estado"),
          BottomNavigationBarItem(
              icon: Icon(Icons.question_mark_outlined), label: "Pregunta"),
          BottomNavigationBarItem(
              icon: Icon(Icons.checklist_sharp), label: "Cuestionario")
        ],
      ),
    );
  }
}
