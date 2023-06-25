import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final BuildContext context;

  NotificationService({required this.context});

  Future<String?> getToken() async {
    return await _firebaseMessaging.getToken();
  }

  void initialize() async {
    // Solicitar permiso al usuario para enviar notificaciones push
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('Permission granted');
    } else {
      print('Permission denied');
    }

    // Manejar la recepción de notificaciones push en la aplicación
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      // Mostrar la notificación push
      showNotification(message);
    });

    // Manejar la apertura de la aplicación desde la notificación push
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      print('Message data: ${message.data}');

      // Navegar a la pantalla correspondiente de acuerdo al tipo de notificación
      navigateToScreen(message);
    });

    // Manejar la recepción de notificaciones push mientras la aplicación está en segundo plano o cerrada
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      print('Notification opened from terminated state');
      print('Message data: ${initialMessage.data}');

      // Navegar a la pantalla correspondiente de acuerdo al tipo de notificación
      navigateToScreen(initialMessage);
    }
  }

  void showNotification(RemoteMessage message) {
    // Configurar la notificación push
    AndroidNotification? android = message.notification?.android;
    RemoteNotification? notification = message.notification;

    if (android != null && notification != null) {
      // Configurar la notificación push para Android
      final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('app_icon');
      final DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
          onDidReceiveLocalNotification: onDidReceiveLocalNotification);
      final InitializationSettings initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

      flutterLocalNotificationsPlugin.initialize(initializationSettings);

      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails('1234', 'Flutter Notification',
              importance: Importance.max, priority: Priority.high, ticker: 'ticker');
      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);

      // Mostrar la notificación push
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        platformChannelSpecifics,
        payload: message.data['payload'],
     );
}}

    void navigateToScreen(RemoteMessage message) {
// Navegar a la pantalla correspondiente de acuerdo al tipo de notificación
String? type = message.data['type'];
switch (type) {
case 'notificationType1':
Navigator.pushNamed(context, '/notificationType1',
arguments: message.data['payload']);
break;
case 'notificationType2':
Navigator.pushNamed(context, '/notificationType2',
arguments: message.data['payload']);
break;
default:
Navigator.pushNamed(context, '/home');
break;
}
}

Future onDidReceiveLocalNotification(
int id, String? title, String? body, String? payload) async {
// Manejar la recepción de notificaciones push locales
}
}