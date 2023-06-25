import 'package:flutter/material.dart';
import '../modelos/encuestas/EncuestasDinamica.dart';
import '../modelos/encuestas/Pregunta.dart';



class EncuestaScreen extends StatelessWidget {
  final EncuestaDinamica encuesta;

  EncuestaScreen({required this.encuesta});

  @override
  Widget build(BuildContext context) {
    // Obtener la pregunta actual
    Pregunta preguntaActual = encuesta.obtenerSiguientePregunta();

    return Scaffold(
      appBar: AppBar(
        title: Text('Encuesta'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              preguntaActual.getTexto(),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Column(
              children: preguntaActual
                  .getOpciones()
                  .map((opcion) => ElevatedButton(
                        onPressed: () {
                          encuesta.sumarPesoOpcion(opcion.peso);
                          if (!preguntaActual.esFinal) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EncuestaScreen(encuesta: encuesta),
                              ),
                            );
                    } else {
                      // Lógica adicional para manejar el caso de pregunta final
                    }
                        },
                        child: Text(opcion.getTexto()),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}