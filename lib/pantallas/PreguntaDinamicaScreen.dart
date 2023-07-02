import 'package:flutter/material.dart';
import '../modelos/encuestas/Opcion.dart';
import '../modelos/encuestas/preguntaDinamica.dart';

class PreguntasDinamicasScreen extends StatefulWidget {
  final List<PreguntaDinamica> preguntas;

  PreguntasDinamicasScreen({required this.preguntas});

  @override
  PreguntasDinamicasScreenState createState() => PreguntasDinamicasScreenState();
}

class PreguntasDinamicasScreenState extends State<PreguntasDinamicasScreen> {
  late List<int?> respuestas;

  void seleccionarOpcion(int preguntaIndex, int opcionIndex) {
    setState(() {
      respuestas[preguntaIndex] = opcionIndex;
    });
  }

  List<Opcion> obtenerOpcionesSeleccionadas() {
    final List<Opcion> opcionesSeleccionadas = [];

    for (int i = 0; i < respuestas.length; i++) {
      final pregunta = widget.preguntas[i];
      final opcionIndex = respuestas[i];
      if (opcionIndex != null) {
        final opcion = pregunta.opciones[opcionIndex];
        opcionesSeleccionadas.add(opcion);
      }
    }

    return opcionesSeleccionadas;
  }

  @override
  void initState() {
    super.initState();
    respuestas = List.generate(widget.preguntas.length, (_) => null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preguntas Dinámicas'),
      ),
      body: ListView.builder(
        itemCount: widget.preguntas.length,
        itemBuilder: (context, index) {
          final pregunta = widget.preguntas[index];
          return Card(
            margin: EdgeInsets.all(16.0),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pregunta.texto,
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: pregunta.opciones.length,
                    itemBuilder: (context, opcionIndex) {
                      final opcion = pregunta.opciones[opcionIndex];
                      return RadioListTile<int>(
                        title: Text(opcion.texto),
                        value: opcionIndex,
                        groupValue: respuestas[index],
                        onChanged: (_) => seleccionarOpcion(index, opcionIndex),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final opcionesSeleccionadas = obtenerOpcionesSeleccionadas();
          // Aquí puedes hacer algo con las opciones seleccionadas, como guardarlas o procesarlas
          print(opcionesSeleccionadas);
        },
        child: Icon(Icons.done),
      ),
    );
  }
}