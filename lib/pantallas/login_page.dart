import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:flutter_application_app/componentes/boton_1.dart';
import 'package:flutter_application_app/componentes/campo_texto.dart';
import 'package:flutter_application_app/componentes/encuadre_img.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  // ----------------[ Controladores de Texto]

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  // -------- signuserIn metodo -----------
  void signUserIn() {}
  // -------- signUserIn metodo-----------

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
                // user textfield------------------------------
                CampoTexto(
                  controller: usernameController,
                  hinttext: 'Nombre de Usuario',
                  textObscuro: false,
                ),
                const SizedBox(height: 10),
                // password textfield--------------------------
                CampoTexto(
                  controller: passwordController,
                  hinttext: 'Password',
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
                        'Forgot Password',
                        style: TextStyle(color: Colors.amber),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // sing in boton------------------------------
                Boton(
                  onTap: signUserIn,
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
                  children: const [
                    EncuadreImg(imagenesPath: 'lib/imagenes/google.png'),
                      SizedBox(height: 10),
                  ],
                ),
                 const SizedBox(height: 10),
          
                // registrar
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('No Registrado',style: TextStyle(color: Colors.grey[700]),),
                       const SizedBox(width: 4),
                       const Text('Registrate ahora',
                       style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)
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
