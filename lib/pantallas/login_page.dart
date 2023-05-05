import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_app/componentes/boton_1.dart';
import 'package:flutter_application_app/componentes/campo_texto.dart';
import 'package:flutter_application_app/componentes/encuadre_img.dart';
import 'package:flutter_application_app/pantallas/auth_page.dart';
import 'package:flutter_application_app/servicios/auth_service.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key,required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  // ----------------[ Controladores de Texto]-----------
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  // -------- sign_User_In metodo -----------
  void signUserIn() async {
    // muestra un circulo de espera hasta q responda la base
    showDialog(context: context, builder: (context){
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
    // trata de hacer el logging
    try{
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
    Navigator.pop(context);
    } on FirebaseAuthException catch(e){
         Navigator.pop(context);
         // Email Error
      if(e.code == 'user-not-found'){
        errorMensaje(e.code.toString());
      }
       // Password Error
      else if(e.code == 'wrong-password'){
         errorMensaje(e.code.toString());
      }
    } 
  }  
  // ------ funcion Mensaje de Alerta -----------
  void errorMensaje(String mensaje){
    showDialog(context: context, builder: (context){
          return   AlertDialog( backgroundColor: Color.fromARGB(255, 231, 165, 222),
              title: Center(
                child: Text( mensaje, style: const TextStyle(color:Colors.purple),), ),);
          },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                // logo----------------------------------------
                const Icon(
                  Icons.lock,
                  size: 100,
                ),

                const SizedBox(height: 50),
                // texto de bienvenida-------------------------
                Text(
                  'Bienvenido',
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),
                const SizedBox(height: 25),
                // email textfield------------------------------
                CampoTexto(
                  controller: emailController,
                  hinttext: 'Email',
                  textObscuro: false,
                ),
                const SizedBox(height: 10),
                // password textfield--------------------------
                CampoTexto(
                  controller: passwordController,
                  hinttext: 'Contraseña',
                  textObscuro: true,
                ),
                const SizedBox(height: 10),
                // forgot password----------------------------
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        'Olvido su contraseña',
                        style: TextStyle(color: Colors.amber),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // sing in boton------------------------------
                Boton(
                  texto:'Sing in',
                  onTap: signUserIn,
                ),
                const SizedBox(height: 10),
                // o continuar con...------------------------
                const Divider(
                  thickness: 5,
                  color: Colors.pinkAccent,
                ),
                // Registro con google ------------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Boton de Google
                    EncuadreImg(
                      onTap: () => AuthService().registroConGoogle(),
                      imagenesPath: 'lib/imagenes/google.png'),
                    const SizedBox(height: 10),
                  ],
                ),
                //  ---------------------------------------------------
                const SizedBox(height: 10),

                // registrar nuevo usuario
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No Registrado',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(  
                       onTap: widget.onTap,
                       child:  const Text(
                        'Registrate ahora',
                        style: TextStyle(
                            color: Colors.blue, 
                            fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
