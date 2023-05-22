import 'package:flutter/material.dart';
import 'customDrawer.dart';


class Notificaciones extends StatefulWidget {
  @override
  _NotificacionesState createState() => _NotificacionesState();
}

class _NotificacionesState extends State<_NotificacionesState> {
  List<String> notifications = [
    'Notificación 1',
    'Notificación 2',
    'Notificación 3',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notificaciones'),
      ),
      drawer: CustomDrawer(),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(notifications[index]),
          );
        },
      ),
    );
  }
}



