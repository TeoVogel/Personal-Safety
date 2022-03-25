import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:personal_safety/utils/checkin_helper.dart';
import 'package:personal_safety/utils/checkin_time_preferences.dart';
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

  Future<void> programCheckInNotification() async {
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

    TimeOfDay checkInTime = await getCheckInTime();
    DateTime now = DateTime.now();
    DateTime scheduledDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      checkInTime.hour,
      checkInTime.minute,
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
        "Perdiem",
        "Time to check-in!",
        tz.TZDateTime.from(utcScheduledDateTime, tz.UTC),
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  Future<void> programDexterityTestNotifications() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            "buffer_channel", //Required for Android 8.0 or after
            "buffer_channel", //Required for Android 8.0 or after
            channelDescription:
                "Buffer window notifications", //Required for Android 8.0 or after
            importance: Importance.high,
            priority: Priority.high);

    const IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails(
      presentAlert: true,
      presentSound: true,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    DateTime lastCheckIn = await getLastCheckIn();
    DateTime checkInWindow = await getCurrentOrUpcomingCheckInWindowStartTime();
    if (lastCheckIn.isAfter(checkInWindow)) {
      checkInWindow = checkInWindow.add(const Duration(days: 1));
    }
    DateTime bufferWindowStartTime =
        checkInWindow.add(const Duration(hours: checkInTimeDurationInHours));

    DateTime utcScheduledDateTime = bufferWindowStartTime.toUtc();
    for (var i = 0; i < 4; i++) {
      _programDexterityTestNotifications(
        2 + i,
        utcScheduledDateTime.add(Duration(minutes: 15 * i)),
        platformChannelSpecifics,
      );
    }
  }

  Future<void> _programDexterityTestNotifications(
    int id,
    DateTime time,
    platformChannelSpecifics,
  ) async {
    print("dexterityTestNotif $time");
    return flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        "Perdiem",
        "Are you okay? You haven't checked-in yet!",
        tz.TZDateTime.from(time, tz.UTC),
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }
}
