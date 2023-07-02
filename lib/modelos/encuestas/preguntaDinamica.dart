import 'dart:io';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:uuid/uuid.dart';
import 'Opcion.dart';

class PreguntaDinamica {
  String id;
  String texto;
  List<Opcion> opciones;

  PreguntaDinamica({
    required this.id,
    required this.texto,
    required this.opciones});

  String get getId => id;

  set setId(String value) {
    id = value;
  }

  String get getTexto => texto;

  set setTexto(String value) {
    texto = value;
  }


  List<Opcion> get getOpciones => opciones;

  set setOpciones(List<Opcion> value) {
    opciones = value;
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> opcionesJson = opciones.map((opcion) =>
        opcion.toJson()).toList();

    return {
      'id': id,
      'texto': texto,
      'opciones': opcionesJson,
    };
  }

  factory PreguntaDinamica.fromData(Map<String, dynamic> data) {
    List<dynamic> opcionesData = data['opciones'];

    List<Opcion> opciones = opcionesData.map((opcionData) {
      return Opcion.fromData(opcionData);
    }).toList();

    return PreguntaDinamica(
      id: data['id'],
      texto: data['texto'],
      opciones: opciones,
    );
  }
}