import 'package:flutter/material.dart';
import 'package:flutter_application_app/servicios/firebase_service.dart';


// <-----------------------------[ ESTA PAGINA SE BORRARA ES SOLO PARA PROBAR FUNCIONES DE EDITADO ]

class editProfesional extends StatefulWidget { // <-creo una pagina con StatefulWidget
  const editProfesional({super.key});

  @override
  State<editProfesional> createState() => _editProfesionalState();
}

class _editProfesionalState extends State<editProfesional> {// <-el cuerpo de la pagina
 
 TextEditingController nameController = TextEditingController(text: "");// <-revisa el texto ingresado en la caja de texto\si esta vacio " " o no
  TextEditingController apellidoController = TextEditingController(text: "");
  TextEditingController celularControler = TextEditingController(text: "");
    TextEditingController dniControler = TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
// ---------------------------------------------------------------------------------
// creo variable arguments para almacenar el objeto que me manda la base de datos
    final Map arguments=ModalRoute.of(context)!.settings.arguments as Map;
        final Map arguments2=ModalRoute.of(context)!.settings.arguments as Map;
         final Map arguments3=ModalRoute.of(context)!.settings.arguments as Map;
            final Map arguments4=ModalRoute.of(context)!.settings.arguments as Map;
              final Map arguments5=ModalRoute.of(context)!.settings.arguments as Map;
// ---------------------------------------------------------------------------------
    apellidoController.text=arguments2['apellido'];//<--- le paso el campo del objeto persona a la variable apellidoController
    nameController.text=arguments3['nombre'];     
    celularControler.text=arguments4['celular'];
    dniControler.text=arguments5['dni'];
    return Scaffold(
      appBar: AppBar(title: const Text('Modificar Datos'),
      ),
      body:Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children:[
           TextField(
            controller: apellidoController, // <-la variable[nameController] guarda el texto ingresado por teclado
            decoration: const InputDecoration(hintText: 'Ingrese apellido'),
          ),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(hintText: 'Ingrese nombre'),
          ),
            TextField(
            controller: celularControler,
            decoration: const InputDecoration(hintText: 'Ingrese Celular'),
          ),
                TextField(
            controller: dniControler,
            decoration: const InputDecoration(hintText: 'Ingrese DNI'),
          ),
          ElevatedButton(onPressed: ()async{
           // print(arguments['uid']);  // <-lariable[nameController] me fijo si capturo algo
            // ---Hay que crear la funcion para guardar en la base de datos en la carpeta Servicios firebase_servicios.dart
             // ---luego la llamo aca--!!controlar que no esta vacio  NULL sino se rompe la basee
            await actualizaProfesional(arguments['uid'], apellidoController.text,nameController.text,celularControler.text,dniControler.text)
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