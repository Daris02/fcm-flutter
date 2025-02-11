import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({ super.key });

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;
    
    return Scaffold(
      appBar: AppBar(title: Text('Notification'),),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Text('Title: ${message.notification?.title.toString()}'),
            Text('Body: ${message.notification?.body.toString()}', style: TextStyle(fontSize: 20),),
          ],
        ),
      ),
    );
  }
}