import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../modelos/encuestas/EncuestasDinamica.dart';
import '../modelos/encuestas/Opcion.dart';
import '../modelos/encuestas/Pregunta.dart';
import '../servicios/firebase_service.dart';
import '../servicios/FirebaseServiceEncuestas.dart';

class EncuestaScreen extends StatefulWidget {

  @override
  EncuestaScreenState createState() => EncuestaScreenState();
}


class EncuestaScreenState extends State<EncuestaScreen> {
  Pregunta? preguntaActual;
  static String user_id = FirebaseAuth.instance.currentUser!.uid;
  static Future<List<String>> encuestas_id = obtenerEncuestasDePaciente(user_id);
  static EncuestaDinamica encuesta = EncuestaService().obtenerEncuestaPorId(encuestas_id as String) as EncuestaDinamica;

  @override
  void initState() {
    super.initState();
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