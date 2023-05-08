import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_app/servicios/firebase_service.dart';

// <-----------------------------[ ESTA PAGINA ES SE MUESTRA SOLO SI INICIO SESION ] ------------------------
class HomeInicio extends StatelessWidget {
  HomeInicio({super.key});
  //---------[ Funcion de logOut de firebase ]
void signUserOut(){
  FirebaseAuth.instance.signOut();
}
final user = FirebaseAuth.instance.currentUser!;
//--------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                      actions: [IconButton(onPressed: signUserOut, icon: const Icon(Icons.logout))],
                      title: const Text('A Iniciado sesion correctamente'),
                      ),// <---FUNCION QUE CIERRA LA SESION
      // <--------------[FIN DE APPBAR] -----------------------------------
      body:SafeArea( 
        child: Center(
          child: SingleChildScrollView(
            child: Row(   
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Column(
                    children: [
                         const SizedBox(height:5),
                      Text( "Correo:" + user.email!, style:  const TextStyle(fontSize: 17)),
                     const SizedBox(height: 5),
                      Text('Nombre:'+user.displayName.toString(),style:   const TextStyle(fontSize: 17)),
                           const SizedBox(height: 5),
                       Text('Uid: '+user.uid.toString(), style:     const TextStyle(fontSize: 17,)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
        
        
        ),
        
     ),
   
    );
  }
}