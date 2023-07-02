import 'dart:io';
import '../../servicios/FirebaseServiceEncuestas.dart';
import 'Opcion.dart';
import 'Pregunta.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';
import 'package:uuid/uuid.dart';

class EncuestaDinamica {
  String id;
  String nombre;
  List<Pregunta> preguntas;
  int pesoTotal;

  EncuestaDinamica({
    required this.id,
    required this.nombre,
    required this.preguntas,
    required this.pesoTotal});

  // Setter y getter para el ID
  void setId(String id) {
    this.id = id;
  }

  String getId() {
    return id;
  }

  // Setter y getter para el nombre de la encuesta
  void setNombre(String id) {
    this.nombre = nombre;
  }

  String getNombre(String nombre) {
    return nombre;
  }

  // Setter y getter para la lista de preguntas
  void setPreguntas(List<Pregunta> preguntas) {
    this.preguntas = preguntas;
  }

  List<Pregunta> getPreguntas() {
    return preguntas;
  }

  // Setter y getter para el peso total
  void setPesoTotal(int pesoTotal) {
    this.pesoTotal = pesoTotal;
  }

  int getPesoTotal() {
    return pesoTotal;
  }

  //Funcion para obtener la pregunta dependiendo del pesoTotal que lleve la encuesta
  Pregunta obtenerSiguientePregunta() {
    int inicio = 0;
    int fin = preguntas.length - 1;
    Pregunta? siguientePregunta;
    int diferenciaMinima = double.infinity.toInt();

    while (inicio <= fin) {
      int medio = inicio + ((fin - inicio) ~/ 2);
      Pregunta preguntaActual = preguntas[medio];
      int diferencia = (preguntaActual.peso - pesoTotal).abs();

      if (diferencia < diferenciaMinima) {
        diferenciaMinima = diferencia;
        siguientePregunta = preguntaActual;
      }

      if (preguntaActual.peso < pesoTotal) {
        inicio = medio + 1;
      } else {
        fin = medio - 1;
      }
    }

    return siguientePregunta!;
  }

  //funcion para oredenar las preguntas dependiendo de su atributo peso
  void ordenarPreguntasPorPeso() {
    preguntas.sort((a, b) => a.peso.compareTo(b.peso));
  }

  //funcion para sumar el peso de la encuesta con el peso de la opcion elegida en pantalla
  void sumarPesoOpcion(int pesoOpcion) {
    pesoTotal += pesoOpcion;
  }

  //NO VA ACA
  //Funcion para crear una encuesta a partir de un excel


  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> preguntasJson = preguntas.map((pregunta) => pregunta.toJson()).toList();

    return {
      'id': id,
      'nombre': nombre,
      'preguntas': preguntasJson,
    };
  }

  factory EncuestaDinamica.fromData(Map<String, dynamic> data) {
    List<dynamic> preguntasData = data['preguntas'];

    List<Pregunta> preguntas = preguntasData.map((preguntaData) {
      return Pregunta.fromData(preguntaData);
    }).toList();

    return EncuestaDinamica(
      id: data['id'],
      nombre: data['nombre'],
      preguntas: preguntas,
      pesoTotal: 0,
    );
  }
}