import 'package:flutter/material.dart';
import 'package:flutter_application_app/pantallas/Profesional_notificaciones.dart';
import 'package:flutter_application_app/pantallas/profesional_modificar_page.dart';
import 'package:flutter_application_app/pantallas/profesional_paciente_page.dart';
import 'package:flutter_application_app/pantallas/registrar_paciente_page.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(  
      backgroundColor: Color((0xFFD9D9D9)),
      width: 98,
      
      
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
      
          ListTile(
            leading: Icon(Icons.manage_accounts),
            title: Text('Modificar'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
              MaterialPageRoute(builder:((context) => ProMod())));

                  
            },
          ),
          ListTile(
            leading: Icon(Icons.assignment_add),
            title: Text('Registrar'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
              MaterialPageRoute(builder:((context) => RegistrarPaciente())));

                },
              ),
          ListTile(
            leading: Icon(Icons.account_circle_outlined),
            title: Text('Pacientes'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                MaterialPageRoute(builder:((context) => ProfesionalxPaciente())));

                },
              ),
          ListTile(
            leading: Icon(Icons.notification_add_outlined),
            title: Text('Notificaciones'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                MaterialPageRoute(builder:((context) => Notificaciones())));

                },
              ),
            ])
          );
     
    
  }
}




