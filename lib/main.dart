import 'package:flutter/material.dart';
import 'package:message_f/firebase_api.dart';
import 'package:message_f/pages/home_page.dart';
import 'package:message_f/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:message_f/pages/notification_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifications();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Messaging Firebase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontSize: 30)
        )
      ),
      navigatorKey: navigatorKey,
      home: HomePage(),
      routes: {
        '/notification-screen': (context) => NotificationPage(),
      },
    );
  }
}
