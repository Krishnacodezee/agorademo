// ignore_for_file: avoid_print

import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class FcmNotification extends StatefulWidget {
  const FcmNotification({Key? key}) : super(key: key);

  @override
  State<FcmNotification> createState() => _FcmNotificationState();
}

// todo: android side notification working
class PushNotification {
  PushNotification({
    this.title,
    this.body,
    this.dataTitle,
    this.dataBody,
  });

  String? title;
  String? body;
  String? dataTitle;
  String? dataBody;
}

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

class _FcmNotificationState extends State<FcmNotification> {
  late int _totalNotifications = 1;

  FirebaseMessaging _messaging = FirebaseMessaging.instance;
  // FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  PushNotification? _notificationInfo;
  @override
  void initState() {
    // _totalNotifications = 0;
    // registerNotification();
    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   PushNotification notification = PushNotification(
    //     title: message.notification?.title,
    //     body: message.notification?.body,
    //   );
    //   setState(() {
    //     _notificationInfo = notification;
    //     _totalNotifications++;
    //   });
    // });
    firebaseCloudMessaging_Listeners();
    super.initState();
  }

  void firebaseCloudMessaging_Listeners() async {
    // if (Platform.isIOS) iOS_Permission();
    print('object');
    print(await FirebaseMessaging.instance.getToken().toString());
    _messaging.getToken().then((token) {
      print('---------->$token');
    });

    // _firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     print('on message $message');
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     print('on resume $message');
    //   },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print('on launch $message');
    //   },
    // );
  }

// void iOS_Permission() {
//   _firebaseMessaging.requestNotificationPermissions(
//       IosNotificationSettings(sound: true, badge: true, alert: true)
//   );
//   _firebaseMessaging.onIosSettingsRegistered
//       .listen((IosNotificationSettings settings)
//   {
//     print("Settings registered: $settings");
//   });
// }
  void registerNotification() async {
    // 1. Initialize the Firebase app
    await Firebase.initializeApp();

    // 2. Instantiate Firebase Messaging
    _messaging = FirebaseMessaging.instance;

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');

      // For handling the received notifications
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        checkForInitialMessage() async {
          await Firebase.initializeApp();
          RemoteMessage? initialMessage =
              await FirebaseMessaging.instance.getInitialMessage();

          if (initialMessage != null) {
            PushNotification notification = PushNotification(
              title: message.notification?.title,
              body: message.notification?.body,
              dataTitle: message.data['title'],
              dataBody: message.data['body'],
            );

            setState(() {
              _notificationInfo = notification;
              _totalNotifications++;
            });
          }
        }

        // Parse the message received
        if (_notificationInfo != null) {
          // For displaying the notification as an overlay
          showSimpleNotification(
            Text(_notificationInfo!.title!),
            leading: NotificationBadge(totalNotifications: _totalNotifications),
            subtitle: Text(_notificationInfo!.body!),
            background: Colors.cyan.shade700,
            duration: const Duration(seconds: 2),
          );
          PushNotification notification = PushNotification(
            title: message.notification?.title,
            body: message.notification?.body,
          );

          setState(() {
            _notificationInfo = notification;
            _totalNotifications++;
          });
        }
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _notificationInfo != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TITLE: ${_notificationInfo!.dataTitle ?? _notificationInfo!.title}',
                      // ...
                    ),
                    Text(
                      'BODY: ${_notificationInfo!.dataBody ?? _notificationInfo!.body}',
                      // ...
                    ),
                    Text(
                      'TITLE: ${_notificationInfo!.title}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'BODY: ${_notificationInfo!.body}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                )
              : const SizedBox(
                  height: 200,
                  child: Center(
                    child: Text('no notification data fetched'),
                  ),
                ),
          const SizedBox(height: 16.0),
          NotificationBadge(totalNotifications: _totalNotifications),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}

class NotificationBadge extends StatelessWidget {
  final int totalNotifications;

  // ignore: use_key_in_widget_constructors
  const NotificationBadge({required this.totalNotifications});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: const BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '$totalNotifications',
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
