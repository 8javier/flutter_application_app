import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_app/componentes/boton_1.dart';
import 'package:flutter_application_app/componentes/campo_texto.dart';
import 'package:flutter_application_app/componentes/encuadre_img.dart';

import '../servicios/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key,required this.onTap,}); 
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}
class _RegisterPageState extends State<RegisterPage> {
  // ----------------[ Controladores de Texto]-----------
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
    final confirmarPasswordController = TextEditingController();
  // -------- Crear_Usuario_Up metodo -----------
  void signUserUp() async {
    // muestra un circulo de espera hasta q responda la base
    showDialog(context: context, builder: (context){
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
    // trata de Registro un nuevo usuario
    try{
       // confirma la Password ingresada
        if(passwordController.text == confirmarPasswordController.text){
                   await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text,
    );
        }else{ // si son distintas mostrar Error de Password
              errorMensaje('La contraseñas no coinciden');
        }
    Navigator.pop(context);
    } on FirebaseAuthException catch(e){
         Navigator.pop(context);
         // Email Error
      if(e.code == 'user-not-found'){
        errorMensaje(e.code);
      }
       // Password Error
      else if(e.code == 'wrong-password'){
         errorMensaje(e.code);
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
                const SizedBox(height: 25),
                // logo----------------------------------------
                const Icon(
                  Icons.lock,
                  size: 50,
                ),
                const SizedBox(height: 25),
                // texto de bienvenida-------------------------
                Text(
                  'Crea tu cuenta',
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
                  // Confirmar password textfield--------------------------
                CampoTexto(
                  controller: confirmarPasswordController,
                  hinttext: 'Confirmar contraseña',
                  textObscuro: true,
                ),
                const SizedBox(height: 10),
           
                // sing in boton------------------------------
                Boton(
                  texto: 'Sing Up',
                  onTap: signUserUp,
                ),
                const SizedBox(height: 10),
                // o continuar con...------------------------
                const Divider(
                  thickness: 5,
                  color: Colors.pinkAccent,
                ),
                // google \\ o otros
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    EncuadreImg(
                    onTap: () => AuthService().registroConGoogle(),
                    imagenesPath: 'lib/imagenes/google.png'),
                    const SizedBox(height: 10),
                  ],
                ),
                const SizedBox(height: 10),

                // registrar
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Ya tienes una cuenta?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector( 
                      onTap: widget.onTap,
                      child: const Text(
                        'Registrate ahora',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
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
