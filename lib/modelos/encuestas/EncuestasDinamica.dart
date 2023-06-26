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
  Future<bool> cargarDesdeExcel() async {
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

      // Obtiene el nombre del archivo como el nombre de la encuesta
      String nombreEncuesta = file.name;

      // Crea un objeto de EncuestaDinamica
      EncuestaDinamica encuesta = EncuestaDinamica(
        id: uuid.v4(),
        nombre:nombreEncuesta,
        preguntas: [],
        pesoTotal: 0,
      );

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
          Pregunta pregunta = Pregunta(
            id: uuid.v4(),
            peso: preguntaPeso as int,
            texto: preguntaTexto!,
            opciones: [],
            esFinal: esFinal,
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

          // Agrega la pregunta a la encuesta
          encuesta.preguntas.add(pregunta);
        }
      }

      // Guarda la encuesta en Firebase
      EncuestaService encuestaService = EncuestaService();
      await encuestaService.guardarEncuestaDinamica(encuesta);

      return true;
    } else {
      // El usuario canceló la selección del archivo
      return false;
    }
  }

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