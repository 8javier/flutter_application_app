import 'package:flutter/material.dart';
import 'package:flutter_application_app/servicios/firebase_service.dart';

class editPacientePage extends StatefulWidget { // <-creo una pagina con StatefulWidget
  const editPacientePage({super.key});

  @override
  State<editPacientePage> createState() => _editPacientePageState();
}

class _editPacientePageState extends State<editPacientePage> {// <-el cuerpo de la pagina
 
 TextEditingController nameController = TextEditingController(text: "");// <-revisa el texto ingresado en la caja de texto\si esta vacio " " o no
  TextEditingController apellidoController = TextEditingController(text: "");
  
  @override
  Widget build(BuildContext context) {
// ---------------------------------------------------------------------------------
// creo variable arguments para almacenar el objeto que me manda la base de datos
    final Map arguments=ModalRoute.of(context)!.settings.arguments as Map;
        final Map arguments2=ModalRoute.of(context)!.settings.arguments as Map;
// ---------------------------------------------------------------------------------
    apellidoController.text=arguments['apellido'];//<--- le paso el campo del objeto persona a la variable apellidoController
    nameController.text=arguments2['nombre'];     //<---
    print(nameController.text);    //<--- controlo q cargue y no este vacio la variable o se rompe todo!!!
    print(apellidoController.text);

    return Scaffold(
      appBar: AppBar(title: const Text('Modificar Datos'),
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
           // print(arguments['uid']);  // <-lariable[nameController] me fijo si capturo algo
            // ---Hay que crear la funcion para guardar en la base de datos en la carpeta Servicios firebase_servicios.dart
             // ---luego la llamo aca--!!controlar que no esta vacio  NULL sino se rompe la basee
            await actualizaPersonas(arguments['uid'], apellidoController.text,nameController.text)
            .then(( value){
            Navigator.pop(context);
            } );
          }, 
          child: const Text('Actualizar'))
        ],
        ),
      )
    );
  }
}