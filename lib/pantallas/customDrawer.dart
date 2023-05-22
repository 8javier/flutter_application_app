import 'package:flutter/material.dart';

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
              MaterialPageRoute(builder:((context) => profesional_modificar_page())));

                  
            },
          ),
          ListTile(
            leading: Icon(Icons.assignment_add),
            title: Text('Registrar'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
              MaterialPageRoute(builder:((context) => registrar_paciente_page())));

                },
              ),
          ListTile(
            leading: Icon(Icons.account_circle_outlined),
            title: Text('Pacientes'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                MaterialPageRoute(builder:((context) => profesional_paciente_page())));

                },
              ),
          ListTile(
            leading: Icon(Icons.notification_add_outlined),
            title: Text('Notificaciones'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                MaterialPageRoute(builder:((context) => profesional_notificaciones_page())));

                },
              ),
            ])
          );
     
    
  }
}




