import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_app/servicios/FirebaseServiceEncuestas.dart';
import '../modelos/encuestas/EncuestasDinamica.dart';
import '../modelos/encuestas/Opcion.dart';
import '../modelos/encuestas/Pregunta.dart';
import '../servicios/firebase_service.dart';

class EncuestaScreen extends StatefulWidget {

  @override
  EncuestaScreenState createState() => EncuestaScreenState();
}


class EncuestaScreenState extends State<EncuestaScreen> {
  Pregunta? preguntaActual;
  EncuestaService encuestaService = new EncuestaService();
  EncuestaDinamica encuesta = new EncuestaDinamica(id: '', nombre: '', preguntas: [], pesoTotal: 0);

  @override
  void initState(){
    super.initState();
    traerEncuesta();
  }

  void traerEncuesta() async {
    String user_id = FirebaseAuth.instance.currentUser!.uid;
    List<String> encuestas_id = await obtenerEncuestasDePaciente(user_id);
    encuesta = (await encuestaService.obtenerEncuestaPorId(encuestas_id[1]))!;
    encuesta.ordenarPreguntasPorPeso();
    preguntaActual = encuesta.obtenerSiguientePregunta();
  }

  void responderPregunta(Opcion opcion) {
    setState(() {
      encuesta.sumarPesoOpcion(opcion.peso);
      preguntaActual = encuesta.obtenerSiguientePregunta();
    });

    if (preguntaActual?.esFinal == true) {
      // Realizar alguna acción cuando se llega a la pregunta final
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(encuesta.nombre),
      ),
      body: preguntaActual != null ? buildPregunta() : Container(),
    );
  }

  Widget buildPregunta() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            preguntaActual!.texto,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: preguntaActual!.opciones.length,
          itemBuilder: (context, index) {
            final opcion = preguntaActual!.opciones[index];
            return ListTile(
              title: Text(opcion.texto),
              onTap: () => responderPregunta(opcion),
            );
          },
        ),
      ],
    );
  }
}