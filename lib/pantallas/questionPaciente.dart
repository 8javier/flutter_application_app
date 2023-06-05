import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class QuestionPaciente extends StatefulWidget {
  const QuestionPaciente({super.key});

  @override
  State<QuestionPaciente> createState() => _QuestionPacienteState();
}

class _QuestionPacienteState extends State<QuestionPaciente> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<String> preguntas = [
    '¿Cuál es tu estado de animo?',
    '¿Has experimentado síntomas físicos relacionados con tu bienestar emocional?',
  ];
List<String> respuestas = List.filled(2, ''); // Lista de respuestas inicialmente vacía
 @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: preguntas.length + 1, // +1 para incluir el botón de guardar
      itemBuilder: (context, index) {
        if (index == preguntas.length) {
          // Último elemento: botón de guardar
          return ElevatedButton(
            onPressed: () {
              guardarRespuestas(); // Lógica para guardar las respuestas
            },
            child: Text('Guardar respuestas'),
          );
        }

        final pregunta = preguntas[index];
        final respuesta = respuestas[index];

        return ListTile(
          title: Text(pregunta),
          subtitle: TextField(
            onChanged: (value) {
              setState(() {
                respuestas[index] = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Ingrese su respuesta',
            ),
            controller: TextEditingController(text: respuesta),
          ),
        );
      },
    );
  }

 void guardarRespuestas() async {
  final pacienteId = FirebaseAuth.instance.currentUser!.uid;

  try {
    for (int i = 0; i < preguntas.length; i++) {
      final pregunta = preguntas[i];
      final respuesta = respuestas[i];

      await firestore
          .collection('respuestas')
          .doc(pacienteId)
          .collection('preguntas')
          .doc('pregunta_$i')
          .set({'pregunta': pregunta, 'respuesta': respuesta});
    }

    print('Respuestas guardadas en Firebase Firestore.');
  } catch (error) {
    print('Error al guardar las respuestas en Firebase Firestore: $error');
  }
}
}