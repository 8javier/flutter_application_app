import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:uuid/uuid.dart';

import '../encuestas/Opcion.dart';

class PreguntaDinamica {
  String id;
  String texto;
  double peso;
  List<Opcion> opciones;

  PreguntaDinamica(this.id, this.texto, this.peso, this.opciones,
  );

  String get getId => id;

  set setId(String value) {
    id = value;
  }

  String get getTexto => texto;

  set setTexto(String value) {
    texto = value;
  }

  double get getPeso => peso;

  set setPeso(double value) {
    peso = value;
  }

  List<Opcion> get getOpciones => opciones;

  set setOpciones(List<Opcion> value) {
    opciones = value;
  }

  Future<bool> cargarPreguntaDesdeExcel() async {
    // Abre el selector de archivos para seleccionar un archivo Excel
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    var uuid = Uuid();

    if (result != null) {
      PlatformFile file = result.files.first;

      // Carga el archivo Excel utilizando la dependencia 'excel'
      var bytes = File(file.path!).readAsBytesSync();
      var excel = Excel.decodeBytes(bytes);

      // Obtiene la hoja de trabajo principal del libro de Excel
      var sheet = excel.tables[excel.tables.keys.first];

      // Obtiene el número total de filas en la hoja
      var rowCount = sheet?.rows.length ?? 0;

      // Itera sobre las filas del archivo Excel
      for (var i = 0; i < rowCount; i += 2) {
        var preguntaRow = sheet!.rows[i];
        var opcionesRow = sheet.rows[i + 1];

        // Verifica si la fila de preguntas y la fila de opciones tienen datos
        if (preguntaRow[0]?.value != null && opcionesRow[0]?.value != null) {
          var preguntaTexto = preguntaRow[0]?.value.toString();
          var preguntaPeso = double.parse(preguntaRow[1]?.value);
          var pregunraFinal = preguntaRow[2]?.value.toString();
          var esFinal = false;

          if (pregunraFinal == 'X' || pregunraFinal == 'x') {
            var esFinal = true;
          }

          // Crea una nueva pregunta
          PreguntaDinamica pregunta = PreguntaDinamica(
            uuid.v4(),
            preguntaTexto!,
            preguntaPeso,
            [],
          );

          // Itera sobre las columnas de opciones y pesos
          for (var j = 0; j < opcionesRow.length; j += 1) {
            if (opcionesRow[j]?.value != null && opcionesRow[j + 1]?.value != null) {
              var opcionTexto = opcionesRow[j]?.value.toString();
              var opcionPeso = double.parse(opcionesRow[j + 1]?.value);

              // Crea una nueva opción y la agrega a la pregunta
              Opcion opcion = Opcion(
                uuid.v4(),
                opcionPeso as int,
                opcionTexto!,

              );
              pregunta.opciones.add(opcion);
            }
          }

        }
      }

      // Calcula el peso total de la encuesta

      return true;
    } else {
      // El usuario canceló la selección del archivo
      return false;

  }
  }
}
