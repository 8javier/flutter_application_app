import 'dart:io';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:uuid/uuid.dart';
import 'Opcion.dart';

class PreguntaDinamica {
  String id;
  String texto;
  double peso;
  List<Opcion> opciones;

  PreguntaDinamica({
    required this.id,
    required this.texto,
    required this.peso,
    required this.opciones});

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

    const uuid = Uuid();

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


          // Crea una nueva pregunta
          PreguntaDinamica pregunta = PreguntaDinamica(
            id: uuid.v4(),
            texto: preguntaTexto!,
            peso: preguntaPeso,
            opciones: [],
          );

          // Itera sobre las columnas de opciones y pesos
          for (var j = 0; j < opcionesRow.length; j += 1) {
            if (opcionesRow[j]?.value != null && opcionesRow[j + 1]?.value != null) {
              var opcionTexto = opcionesRow[j]?.value.toString();
              var opcionPeso = double.parse(opcionesRow[j + 1]?.value);

              // Crea una nueva opción y la agrega a la pregunta
              Opcion opcion = Opcion(
                id: uuid.v4(),
                peso: opcionPeso as int,
                texto: opcionTexto!,

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

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> opcionesJson = opciones.map((opcion) =>
        opcion.toJson()).toList();

    return {
      'id': id,
      'texto': texto,
      'peso': peso,
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
      peso: data['peso'],
      opciones: opciones,
    );
  }
}