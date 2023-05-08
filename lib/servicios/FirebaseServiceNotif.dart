import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseServiceNotif {
  FirebaseServiceNotif._privateConstructor();

  static final FirebaseServiceNotif instance = FirebaseServiceNotif._privateConstructor();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> init() async {
    await Firebase.initializeApp();

    _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    print("Handling a background message: ${message.messageId}");
  }

  Stream<RemoteMessage> get onMessageStream {
    return FirebaseMessaging.onMessage;
  }

  Future<String?> getToken() async {
    return await _firebaseMessaging.getToken();
  }
}
