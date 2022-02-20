import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');

    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      //onDidReceiveLocalNotification: onDidReceiveLocalNotification, for iOS < 10
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);

    tz.initializeTimeZones();
  }

  Future selectNotification(String? payload) async {
    //Handle notification tapped logic here
  }

  Future<void> programNotification(TimeOfDay time) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            "check_in_channel", //Required for Android 8.0 or after
            "check_in_channel", //Required for Android 8.0 or after
            channelDescription:
                "Check In notifications", //Required for Android 8.0 or after
            importance: Importance.high,
            priority: Priority.high);

    const IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails(
      presentAlert:
          true, // Present an alert when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
      //presentBadge: true,  // Present the badge number when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
      presentSound:
          true, // Play a sound when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
      //sound: String?,  // Specifics the file path to play (only from iOS 10 onwards)
      //badgeNumber: int?, // The application's icon badge number
      //attachments: List<IOSNotificationAttachment>?, (only from iOS 10 onwards)
      //subtitle: String?, //Secondary description  (only from iOS 10 onwards)
      //threadIdentifier: String? (only from iOS 10 onwards)
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    DateTime now = DateTime.now();
    DateTime scheduledDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
    if (scheduledDateTime.isBefore(now)) {
      scheduledDateTime = scheduledDateTime.add(const Duration(days: 1));
    }
    DateTime utcScheduledDateTime = scheduledDateTime.toUtc();

    print(now);
    print(scheduledDateTime);
    print(utcScheduledDateTime);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        1,
        "Personal Safety",
        "Time to check-in!",
        tz.TZDateTime.from(utcScheduledDateTime, tz.UTC),
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }
}
