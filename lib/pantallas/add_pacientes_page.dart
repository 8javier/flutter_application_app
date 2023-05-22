import 'package:flutter/material.dart';
import 'package:flutter_application_app/servicios/firebase_service.dart';

class AddPacientesPage extends StatefulWidget {
  // <-creo una pagina con StatefulWidget
  const AddPacientesPage({super.key});

  @override
  State<AddPacientesPage> createState() => _AddPacientesPageState();
}

class _AddPacientesPageState extends State<AddPacientesPage> {
  // <-COMIENSA EL cuerpo de la pagina

  TextEditingController nameController = TextEditingController( text: ""); // <-revisa el texto ingresado en la caja de texto\
  TextEditingController apellidoController = TextEditingController(text: "");
  final dniController = TextEditingController();
  final celularController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Registrar a Paciente'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Column(
            children: [
              TextField(
                autofocus: true,
                controller:
                    nameController, // <-la variable[nameController] guarda el texto ingresado por teclado
                decoration: const InputDecoration(hintText: 'Ingrese nombre'),
              ),
              TextField(
                autofocus: true,
                controller: apellidoController,
                decoration: const InputDecoration(hintText: 'Ingrese apellido'),
              ),
              TextField(
                autofocus: true,
                controller: dniController,
                decoration: const InputDecoration(hintText: 'Ingrese DNI'),
              ),
              TextField(
                autofocus: true,
                controller: celularController,
                decoration: const InputDecoration(hintText: 'Ingrese Celular'),
              ),

              ElevatedButton(
                  onPressed: () async {
                    print('Nombre :${nameController.text}');
                    print('apellido :${apellidoController.text}');
                    print('DNI:${dniController.text}');
                    print('Celular:${celularController.text}');
                    // <-lariable[nameController] me fijo si capturo algo
                    // ---SE USA LA funcion para guardar en la base de datos en la carpeta Servicios firebase_servicios.dart
                         await addPacientes(nameController.text, apellidoController.text, dniController.text, celularController.text).then((value) {
                         Navigator.pop(context);
                         });
                  },
                  child: const Text('Guardar'))
            ],
          ),
        ));
  }
}
