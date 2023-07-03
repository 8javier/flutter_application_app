import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_app/modelos/paciente_datos.dart';
import 'package:flutter_application_app/servicios/firebase_service.dart';
import '../modelos/encuestas/Opcion.dart';
import '../modelos/encuestas/preguntaDinamica.dart';
import '../servicios/FirebaseServiceEncuestas.dart';

class PreguntasDinamicasScreen extends StatefulWidget {

  @override
  PreguntasDinamicasScreenState createState() => PreguntasDinamicasScreenState();
}

class PreguntasDinamicasScreenState extends State<PreguntasDinamicasScreen> {
  List<int?> respuestas = [];
  EncuestaService encuestaService = new EncuestaService();
  List<PreguntaDinamica?> preguntas = [];
  List<dynamic> preguntasJson = [];
  List<PreguntaDinamica> preguntasSeleccionadas = [];
  String user_id = FirebaseAuth.instance.currentUser!.uid;
  Paciente paciente = Paciente();

  void traerEncuesta() async {
    paciente = (await obtenerPacientePorId(user_id))!;
    preguntasJson = await obtenerPreguntasDePaciente(user_id);
    List<String> preguntasIds = preguntasJson.cast<String>();
    for (int i = 0; i < preguntasIds.length; i++ ) {
      print(preguntasIds[i]);
      preguntas.add( await encuestaService.obtenerPreguntaPorId(preguntasIds[i]));
      print(preguntas[i]?.texto);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    traerEncuesta();
  }

  void mostrarOpciones(PreguntaDinamica pregunta) {
    setState(() {
      preguntasSeleccionadas = [pregunta];
    });
  }

  void seleccionarOpcion(Opcion opcion) {
    actualizaEstadoPaciente(user_id, paciente.getEstado()! + opcion.getPeso());
    eliminaPreguntasDePaciente(user_id, preguntasSeleccionadas[0].id);
    preguntas.remove(preguntasSeleccionadas[0]);
    preguntasSeleccionadas = [];
    setState(() {
    });
    // Implementa la lógica para manejar la selección de la opción
    // ...
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preguntas Dinámicas'),
      ),
      body: ListView.builder(
        itemCount: preguntas.length,
        itemBuilder: (context, index) {
          final pregunta = preguntas[index];
          return Column(
            children: [
              ListTile(
                title: Text(pregunta!.texto),
                onTap: () {
                  mostrarOpciones(pregunta);
                  // Acción al seleccionar la pregunta
                  // Puedes agregar aquí la lógica para mostrar las opciones y manejar la respuesta
                },
              ),
              if (preguntasSeleccionadas.contains(pregunta))
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: pregunta.opciones.length,
                  itemBuilder: (context, opcionIndex) {
                    final opcion = pregunta.opciones[opcionIndex];
                    return ListTile(
                      title: Text(opcion.texto),
                      onTap: () {
                        seleccionarOpcion(opcion);
                      },
                    );
                  },
                ),
            ],
          );
        },
      ),
    );
  }
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {
          final opcionesSeleccionadas = obtenerOpcionesSeleccionadas();
          // Aquí puedes hacer algo con las opciones seleccionadas, como guardarlas o procesarlas
          print(opcionesSeleccionadas);
        },
        child: Icon(Icons.done),
      ),
    );
  }*/
}