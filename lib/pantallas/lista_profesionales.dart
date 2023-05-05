
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_app/servicios/firebase_service.dart';


// <-----------------------------[ ESTA PAGINA SE MUESTRA LA LISTA DE PROFESIONALES SOLO PARA PROBAR LAS FUNCIONES PARA TRAER DATOS DE LA BASE] ------------------------
class ListaProfesionales extends StatefulWidget {
  const ListaProfesionales({super.key});

  @override
  State<ListaProfesionales> createState() => _ListaProfesionalesState();
}

class _ListaProfesionalesState extends State<ListaProfesionales> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          title: const Text('lista de Profesionales'),
        ),
        body: FutureBuilder(
              future: getProfesionles(),
       
              builder: ((context, snapshot) {
                  if(snapshot.hasData){
                    return ListView.builder(
                     itemCount: snapshot.data?.length,
                     itemBuilder: (context, index) {
                    return  ListTile(
                      leading:const Text('Profesional Datos:'),
                      title:Text('Nombre:${snapshot.data?[index]['nombre']}'),
                      subtitle:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Apellido:${snapshot.data?[index]['apellido']}'),
                           Text('Celular:${snapshot.data?[index]['celular']}'),
                            Text('DNI:${snapshot.data?[index]['dni']}'),
                             Text('Matricula:${snapshot.data?[index]['matricula']}'),
                              Text('ID:${snapshot.data?[index]['id']}'),
                        ],
                      )
                    
                    
                    );
                    
                    
                    //Text(snapshot.data?[index]['nombre']);
                  },
                    );
                } else{
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
    
              }  
              
              ),
        ),
        
    );
  }
}