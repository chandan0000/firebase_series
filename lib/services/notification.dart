import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  log("message received! ${message.notification!.title}");
}

class NotificationS {
  static Future<void> initialize() async {
    NotificationSettings setting =
        await FirebaseMessaging.instance.requestPermission();
    if (setting.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onBackgroundMessage(backgroundHandler);

      FirebaseMessaging.onMessage.listen((message) {
        log("Message received ${message.notification!.title}");
      });
      log("Notification initlize");
    }
  }
}
