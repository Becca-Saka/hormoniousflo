import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final flutterNotifications = FlutterLocalNotificationsPlugin();

  static NotificationDetails notificationDetails = const NotificationDetails(
    android: AndroidNotificationDetails(
      'channelId',
      'channelName',
      channelDescription: 'channelDescription',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    ),
    iOS: IOSNotificationDetails(),
  );

  /// Initializes the notification service
  static Future<bool?> init() async {
    initializeTimeZones(); // initialize timezone

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    return await flutterNotifications.initialize(
      initializationSettings,
    );
    
  }

  /// Used to schedule a notification at a specific time
  static Future<void> scheduleNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledDate,
  }) async {
    tz.TZDateTime scheduledTime = tz.TZDateTime.from(scheduledDate, tz.local);
    return flutterNotifications.zonedSchedule(
      id,
      title,
      body,
      scheduledTime,
      notificationDetails,
      payload: payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  /// Used to clear all notifications before scheduling new ones
  static Future<void> clearAllNotifications() async {
    return flutterNotifications.cancelAll();
  }
}
