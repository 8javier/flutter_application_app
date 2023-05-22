import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_app/componentes/botonNavegapaginas.dart';
import 'package:flutter_application_app/modelos/auth.dart';
import 'package:flutter_application_app/pantallas/add_pacientes_page.dart';
import 'package:flutter_application_app/pantallas/auth_page.dart';
import 'package:flutter_application_app/pantallas/homePacientes.dart';
import 'package:flutter_application_app/pantallas/login_or_register.dart';
import 'package:flutter_application_app/pantallas/mainPaciente.dart';
import 'package:flutter_application_app/servicios/firebase_service.dart';

// <-----------------------------[ ESTA PAGINA ES SE MUESTRA SOLO SI INICIO SESION ] ------------------------
class HomeInicio extends StatelessWidget {
  HomeInicio({super.key});
  //---------[ Funcion de logOut de firebase ]
void signUserOut(){
  FirebaseAuth.instance.signOut();
   NavegarBoton(texto: "", paginaDestino: const LoginOrRegisterPage());// <-lo mandas a esta pantalla que chequea el login
}
//final user = FirebaseAuth.instance.currentUser!;
final User? user = Auth().usuarioActual;

Widget _userUid(){
return Text(user?.email ?? 'Usuario email :');
}

Widget _userName(){
return Text(user?.uid ?? 'UID :');
}

Widget _singOutBoton(){
return ElevatedButton(onPressed: signUserOut, child: const Text('Sing Out'),);
}


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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _userUid(),
                      _userName(),
                    
                      NavegarBoton(texto: "Acceda a  Paciente", paginaDestino: const HomePaciente()),
                      NavegarBoton(texto: 'Ingrese sus datos', paginaDestino: const AddPacientesPage()),
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