
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../servicios/NotificationService.dart';


//CLASE DE EJEMPLO.
//Esto se debe agregar a las pantallas que se quieren mostrar las notificaciones
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late NotificationService notificationService;

  @override
  void initState() {
    super.initState();
    notificationService = NotificationService(context: context);
    notificationService.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Screen'),
      ),
      body: const Center(
        child: Text('This screen receives notifications'),
      ),
    );
  }
}