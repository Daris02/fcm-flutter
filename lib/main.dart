import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:message_f/firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Gère les messages reçus lorsque l'application est en arrière-plan
  print("Message reçu en arrière-plan: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialiser Firebase Messaging
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Demander la permission pour recevoir des notifications
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print("Permission accordée pour les notifications");
  } else {
    print("Permission refusée");
  }

  // Obtenir le token FCM de l'appareil
  String? token = await messaging.getToken();
  print("FCM Token: $token");

  // Gérer les messages en arrière-plan
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();

    // Écouter les messages reçus lorsque l'application est en premier plan
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Message reçu en premier plan: ${message.notification?.title}");

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(message.notification?.title ?? "Notification"),
          content: Text(message.notification?.body ?? "Pas de message"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    });

    // Écouter les messages lorsque l'application est ouverte via une notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Message ouvert via une notification: ${message.data}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('FCM avec Flutter 🚀'),
        ),
      ),
    );
  }
}
