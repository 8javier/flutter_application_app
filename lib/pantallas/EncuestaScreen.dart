import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_app/servicios/FirebaseServiceEncuestas.dart';
import '../modelos/encuestas/EncuestasDinamica.dart';
import '../modelos/encuestas/Opcion.dart';
import '../modelos/encuestas/Pregunta.dart';
import '../modelos/paciente_datos.dart';
import '../servicios/firebase_service.dart';

class EncuestaScreen extends StatefulWidget {

  @override
  EncuestaScreenState createState() => EncuestaScreenState();
}


class EncuestaScreenState extends State<EncuestaScreen> {
  Pregunta? preguntaActual;
  EncuestaService encuestaService = new EncuestaService();
  EncuestaDinamica encuesta = new EncuestaDinamica(id: '', nombre: '', preguntas: [], pesoTotal: 0);
  String user_id = FirebaseAuth.instance.currentUser!.uid;
  Paciente paciente = Paciente();

  @override
  void initState(){
    super.initState();
    traerEncuesta();
  }

  void traerEncuesta() async {
    paciente = (await obtenerPacientePorId(user_id))!;
    List encuestas_id = await obtenerEncuestasDePaciente(user_id);
    print(encuestas_id);
    print('asfafdfafa');
    encuesta = (await encuestaService.obtenerEncuestaPorId(encuestas_id[0]))!;
    encuesta.ordenarPreguntasPorPeso();
    preguntaActual = encuesta.obtenerSiguientePregunta();
    print(preguntaActual?.texto);
    setState(() {});
  }

  void responderPregunta(Opcion opcion) {
    setState(() {
      encuesta.sumarPesoOpcion(opcion.peso);
      preguntaActual = encuesta.obtenerSiguientePregunta();
      setState(() {});
    });

    if (preguntaActual?.esFinal == true) {
      print('Pregunta es Final');
      var estado = paciente.getEstado()! + encuesta.getPesoTotal();
      actualizaEstadoPaciente(user_id, estado);
      eliminaEncuestaDePaciente(user_id, encuesta.getId());
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