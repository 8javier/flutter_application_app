import 'package:cloud_firestore/cloud_firestore.dart';
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
  final nombreController= TextEditingController();
  final apellidoController=TextEditingController();
  final celularController = TextEditingController();
  final dniController = TextEditingController();
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
       // confirma q la Password ingresadas coinciden y lo manda a la base a cargar los datos ingresados
        if(passwordController.text == confirmarPasswordController.text){
                   await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text,           
    );
     addUserData(
          nombreController.text, 
          apellidoController.text, 
          celularController.text, 
          dniController.text, 
          emailController.text,
          );  
        }else{ errorMensaje('Las contraseñas no coinciden');}
         Navigator.pop(context);
    } on FirebaseAuthException catch(e){
         Navigator.pop(context);
         errorMensaje(e.code);
    } 
   
  }  
 
   // ------ funcion Agrega los datos del usuario a la base -----------
  Future addUserData(String nombre,String apellido,String celular,String dni,String email)async{
    await FirebaseFirestore.instance.collection("Pacientess").add({
     'nombre':nombre ,
     'apellido':apellido ,
     'celular': celular,
     'dni': dni,
     'email': email,
    });
  }
 
  // ------ funcion Mensaje de Alerta -----------
  void errorMensaje(String mensaje){
    showDialog(context: context, builder: (context){
          return   AlertDialog( backgroundColor: const Color.fromARGB(255, 231, 165, 222),
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
                  controller: nombreController,
                  hinttext: 'Nombre',
                  textObscuro: false,
                ),
                const SizedBox(height: 10),
                  // email textfield------------------------------
                CampoTexto(
                  controller: apellidoController,
                  hinttext: 'Apellido',
                  textObscuro: false,
                ),
                const SizedBox(height: 10),
                  // email textfield------------------------------
                CampoTexto(
                  controller: celularController,
                  hinttext: 'Celular',
                  textObscuro: false,
                ),
                const SizedBox(height: 10),
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
                  hinttext: 'Repetir contraseña',
                  textObscuro: true,
                ),
                const SizedBox(height: 10),
           
                // sing in boton------------------------------
                Boton(
                  texto: 'Registrarse',
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
                    onTap: () => AuthService().registroConGoogle(), // <-- verrr SignIn
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
                        'Registrarse ahora',
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
