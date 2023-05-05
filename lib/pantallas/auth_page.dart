import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_app/pantallas/home_inicio.dart';
import 'package:flutter_application_app/pantallas/login_or_register.dart';
import 'package:flutter_application_app/pantallas/login_page.dart';
import 'package:flutter_application_app/pantallas/register_page.dart';


//---------[ Pagina para verificar si el usuario esta logeado o no ,Y LO REDIRECCIONA A LA PAGINA QUE LE CORRESPONDA]
class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder:(context, snapshot) {
            //-- user Si logged in 
            if(snapshot.hasData){
              return   HomeInicio();
            }

            //-- user No logged in
            else {
              return const LoginOrRegisterPage();
            }
          },
        ),
    );
  }
}