import 'package:flutter/material.dart';
import 'package:flutter_application_app/servicios/firebase_service.dart';

class AddPacientePage extends StatefulWidget { // <-creo una pagina con StatefulWidget
  const AddPacientePage({super.key});

  @override
  State<AddPacientePage> createState() => _AddPacientePageState();
}

class _AddPacientePageState extends State<AddPacientePage> {// <-el cuerpo de la pagina
 
 TextEditingController nameController = TextEditingController(text: "");// <-revisa el texto ingresado en la caja de texto\si esta vacio " " o no
  TextEditingController apellidoController = TextEditingController(text: "");
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ingrese nombre'),
      ),
      body:Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children:[
           TextField(
            controller: nameController, // <-la variable[nameController] guarda el texto ingresado por teclado
            decoration: const InputDecoration(hintText: 'Ingrese nombre'),
          ),
          TextField(
            controller: apellidoController,
            decoration: const InputDecoration(hintText: 'Ingrese apellido'),
          ),
          ElevatedButton(onPressed: ()async{
            //print(nameController.text);  // <-lariable[nameController] me fijo si capturo algo
            // ---Hay que crear la funcion para guardar en la base de datos en la carpeta Servicios firebase_servicios.dart
             // ---luego la llamo aca
             await addPaciente(nameController.text,apellidoController.text).then((value) {
              Navigator.pop(context);
             });
             
          }, child: const Text('Guardar'))
        ],
        ),
      )
    );
  }
}