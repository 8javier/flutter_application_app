import 'package:flutter/material.dart';
import 'package:flutter_application_app/pantallas/login_page.dart';
import 'package:flutter_application_app/pantallas/register_page.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});
  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}
class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
 // al Inicio Muestra la Login Page
 bool mostrarLoginPage = true;
   //-------------------- Selecciona entre la Login Page y Page de Registro
  void seleccionaPagina(){
    setState(() {
      mostrarLoginPage = !mostrarLoginPage;
    });
  }
   //----------------------------------------------------
  @override
  Widget build(BuildContext context) {
    if(mostrarLoginPage){
      return LoginPage(
        onTap:seleccionaPagina ,
      );
    }else{
      return RegisterPage(
        onTap: seleccionaPagina,
      );
    }
  }
}