import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../modelos/encuestas/EncuestasDinamica.dart';
import '../modelos/encuestas/Opcion.dart';
import '../modelos/encuestas/Pregunta.dart';
import '../modelos/encuestas/preguntaDinamica.dart';
import '../modelos/paciente_datos.dart';
import '../modelos/provider/profesional_provider.dart';
import '../servicios/FirebaseServiceEncuestas.dart';
import 'dart:io';

class ListaPacientePage extends StatefulWidget {
  const ListaPacientePage({super.key});
  @override
  State<ListaPacientePage> createState() => _ListaPacientePageState();
}
class _ListaPacientePageState extends State<ListaPacientePage> {
  @override
  void initState() {
    super.initState();
    // Carga los pacientes del profesional al iniciar la página
    final profesionalProvider = Provider.of<ProfesionalProvider>(context, listen: false);
    profesionalProvider.cargarPacientesLista();
  }

  @override
  Widget build(BuildContext context) {
    final profesionalProvider = Provider.of<ProfesionalProvider>(context);
    final List<Paciente> pacientes = profesionalProvider.pacientesLista;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Pacientes'),
        backgroundColor: const Color(0xff0047ab),
      ),
      body: ListView.builder(
        itemCount: pacientes.length,
        itemBuilder: (context, index) {
          final paciente = pacientes[index]; // Carga para mostrar la info en pantalla
          return ListTile(
            title: Text(paciente.nombre ?? ''),
            subtitle: Text(paciente.apellido ?? ''),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.add_card),
                  onPressed: () {
                    cargarPreguntaDesdeExcel(paciente.id); // Llama a la función para enviar el mensaje al paciente
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.add_chart),
                  onPressed: () {
                    cargarEncuestaDesdeExcel(paciente.id); // Llama a la función para enviar el mensaje al paciente
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    eliminarPaciente(paciente); // Llama a la función para eliminar el paciente
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> enviarMensaje(Paciente paciente) async {
    final profesionalProvider = Provider.of<ProfesionalProvider>(context, listen: false);
    // Captura la información del paciente seleccionado
    final pacienteId = paciente.id;
    final collectionReference = FirebaseFirestore.instance.collection("paciente/$pacienteId");
    // Verifica si la subcolección "mensajeProfesional" existe
    final subcollectionReference = collectionReference.doc(pacienteId).collection("mensajeProfesional");
    final snapshot = await subcollectionReference.get();
    if (snapshot.docs.isEmpty) {
      print('La colección "mensajeProfesional" no existe. Creando...');
      await subcollectionReference.doc().set({});
      print('La colección "mensajeProfesional" ha sido creada con éxito.');
    } else {
      print('La colección "mensajeProfesional" ya existe.');
    }
    // Agrega el mensaje al documento en la subcolección
    await subcollectionReference.add({
      "mensaje": "Este es un mensaje para el paciente",
      "fecha": DateTime.now(),
    });
  }
  void eliminarPaciente(Paciente paciente) {// funcion que elimina de la DB del peofesional
    final profesionalProvider = Provider.of<ProfesionalProvider>(context, listen: false);
    profesionalProvider.eliminarPaciente(paciente);
  }

  Future<bool> cargarEncuestaDesdeExcel(String? id) async {
    // Abre el selector de archivos para seleccionar un archivo Excel
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'],
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
          print(preguntaTexto);
          int preguntaPeso = preguntaRow[1]?.value;
          print(preguntaPeso);
          var preguntaFinal = preguntaRow[2]?.value.toString();
          var esFinal = false;
          if (preguntaFinal != null) {
            esFinal = true;
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
          for (var j = 0; j < opcionesRow.length; j += 2) {
            if (opcionesRow[j]?.value != null && opcionesRow[j + 1]?.value != null) {
              var opcionTexto = opcionesRow[j]?.value.toString();
              int opcionPeso = opcionesRow[j + 1]?.value;

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
      List<String> encuestaId = [encuesta.id];
      await encuestaService.cargarEncuestaAlPaciente(id, encuestaId);

      return true;
    } else {
      // El usuario canceló la selección del archivo
      return false;
    }
  }

  Future<bool> cargarPreguntaDesdeExcel(String? id) async {
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
      EncuestaService encuestaService = EncuestaService();
      List<String> preguntasIds = [];

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
          print(preguntaTexto);


          // Crea una nueva pregunta
          PreguntaDinamica pregunta = PreguntaDinamica(
            id: uuid.v4(),
            texto: preguntaTexto!,
            opciones: [],
          );

          // Itera sobre las columnas de opciones y pesos
          for (var j = 0; j < opcionesRow.length; j += 2) {
            if (opcionesRow[j]?.value != null && opcionesRow[j + 1]?.value != null) {
              var opcionTexto = opcionesRow[j]?.value.toString();
              print(opcionesRow[j + 1]?.value);
              int opcionPeso = opcionesRow[j + 1]?.value.round();

              // Crea una nueva opción y la agrega a la pregunta
              Opcion opcion = Opcion(
                id: uuid.v4(),
                peso: opcionPeso,
                texto: opcionTexto!,

              );
              print(opcionTexto);
              pregunta.opciones.add(opcion);
            }
          }

          await encuestaService.guardarPreguntaDinamica(pregunta);
          preguntasIds.add(pregunta.id);

        }
      }
      await encuestaService.cargarPreguntasAlPaciente(id, preguntasIds);



      return true;
    } else {
      // El usuario canceló la selección del archivo
      return false;
    }
  }
}