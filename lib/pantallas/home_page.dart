import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_app/pantallas/homePacientes.dart';
import 'package:flutter_application_app/pantallas/home_inicio.dart';
import 'package:flutter_application_app/servicios/firebase_service.dart';

import '../componentes/botonNavegapaginas.dart';
import 'login_or_register.dart';

// <-----------------------------[ ESTA PAGINA ES SOLO PARA TESTING  ] ------------------------
class Home extends StatefulWidget {
  // <-es una extraccion de home:home()
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                      title: const Text('Lista de Pacientes'), 
      ),
      body: FutureBuilder(
          future:
              getPacientes(), // <-llama a la funcion declarada en la carpeta servicios que trae los datos de la base de datos
          builder: (context, snapshot) {
            //<-snapshot recibe getPersonas()
            if (snapshot.hasData) {
              //<-snapshot si no esta NULL lo muestra
              return ListView.builder(
                itemCount: snapshot.data
                    ?.length, // <-- array de los datos q muestra en la pantalla (en un estado)
                itemBuilder: (context, index) {
                  // --------------------------------------------------------------------------
                  return Dismissible(
                    // <-se vuelve un widget tipo Dismissible que le da a cada elemento movimientos y atributos com el borrado
                    onDismissed: (direction) async {
                      // <-se llama a la funcion de borrado
                      await borradoPaciente(snapshot.data?[index][
                          'uid']); // <-- recibe el id para el borrado en la base
                      snapshot.data?.removeAt(
                          index); // <-- borra el elemento del array para que muestre en pantalla los datos correctos y no genere conflictos
                    },
                    confirmDismiss: (direction) async {
                      // <-se genera cuadro de confirmacion de borrado
                      bool result = true;
                      result = await showDialog(
                          context: context,
                          builder: (contex) {
                            return AlertDialog(
                              title: Text(
                                  'Quiere borrar a ${snapshot.data?[index]['apellido']}'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      return Navigator.pop(
                                        contex,
                                        false,
                                      );
                                    },
                                    child: const Text('Cancelar')),
                                TextButton(
                                    onPressed: () {
                                      return Navigator.pop(
                                        contex,
                                        true,
                                      );
                                    },
                                    child: const Text('Aceptar'))
                              ],
                            );
                          });
                      return result; // <-devuelve true o false para confirmar si quiere el borrado
                    },
                    // --------------------------------------------------------------------------
                    background: Container(
                      color: Colors.redAccent,
                      child: const Icon(Icons.delete),
                    ),
                    direction: DismissDirection.endToStart,
                    key: Key(snapshot.data?[index][
                        'uid']), // <-le asigna una ID a cada elemento persona el de la base de datos
                    child: ListTile(
                        title: const Text('Datos'), //<-- [saca el dato de la base]
                         subtitle:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Apellido:${snapshot.data?[index]['apellido']}'),
                          Text('Nombre:${snapshot.data?[index]['nombre']}'),
                           Text('Celular:${snapshot.data?[index]['celular']}'),
                            Text('DNI:${snapshot.data?[index]['dni']}'),
                              Text('uID:${snapshot.data?[index]['uid']}'),
                        ],

                      ),
                        
                        onTap: (() async {
                          await Navigator.pushNamed(context, '/edit',
                              arguments: {
                                "apellido": snapshot.data?[index]['apellido'],
                                "nombre": snapshot.data?[index]['nombre'],
                                "celular":snapshot.data?[index]['celular'],
                                "dni":snapshot.data?[index]['dni'],
                                "uid": snapshot.data?[index]
                                    ['uid'], //<-- [saca el ID de la base]
                              });
                          setState(() {
                            //<--  A ctualiza los cambios con los de la base para q lo muestre por pantalla
                          });
                        }),
                        
                        ),

                  );
                },
              );

            } else {
              return const Center(
                //<-snapshot si esta NULL
                child: CircularProgressIndicator(), //<-pinta un circulo
              );
            }            
          }),

      floatingActionButton: FloatingActionButton(
        heroTag: 'AGREGAR PROFESIONAL',
        onPressed: () async {
          //<-agrega un async por que se interactua con la base de datos
          await Navigator.pushNamed(context,
              '/addProfesional'); //<-agrega await para que pause la sincronia con la base y hace una actualizacion de los datos que hay en la base aca va '/add' de paciente

          setState(
              () {}); //<-- actualiza la info del Home_page para que muestre los datos da la base de datos
        },
        child: const Icon(Icons.add),
      ),

      bottomSheet: FloatingActionButton(
        heroTag: 'AGREGAR PACIENTE',
        onPressed: () async {
          await Navigator.pushNamed(context, '/addPaciente');

          setState(() {});
        },
        child: const Icon(Icons.accessibility_new),
      ),

      bottomNavigationBar: FloatingActionButton.large(
        heroTag: 'LISTAR PROFESIONALES',
        onPressed: () async {
          await Navigator.pushNamed(context, '/lisProfesional');
          setState(() {});
        },
        child: const Icon(Icons.list_alt_sharp),
      ),

    );
   
  }
}

