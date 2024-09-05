import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService extends ChangeNotifier {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  List<String> scheduledNotifications = [];

  NotificationService({required this.flutterLocalNotificationsPlugin}) {
    tz.initializeTimeZones();
    initializeNotifications();
  }

  Future<bool?> initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    // Initialisierung der Benachrichtigungen mit eventuellem Callback
    return await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        debugPrint("Benachrichtigung empfangen: ${response.payload}");
        // Hier kann Logik hinzugefügt werden, wenn eine Benachrichtigung angeklickt wird.
      },
    );
  }

  Future<void> createNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'your_channel_id', // ID des Kanals
      'your_channel_name', // Name des Kanals
      description: 'your channel description', // Beschreibung des Kanals
      importance: Importance.high, // Wichtigkeit auf 'high' gesetzt
    );

    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    await androidImplementation?.createNotificationChannel(channel);
  }

  Future<void> showNotificationWithAction(int id, TimeOfDay time) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your channel description',
      importance: Importance.high, // Wichtigkeit auf 'high' gesetzt
      priority: Priority.high, // Priorität auf 'high' gesetzt
      actions: <AndroidNotificationAction>[
        AndroidNotificationAction(
          'drink_now',
          'Getrunken',
        ),
      ],
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    // Zeit für die Benachrichtigung in 5 Sekunden festlegen
    final tz.TZDateTime scheduledTime = now.add(const Duration(seconds: 5));

    debugPrint("Benachrichtigung geplant für: $scheduledTime");

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      'Erinnerung',
      'Hast du gerade Wasser getrunken?',
      scheduledTime,
      platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );

    String notificationTime =
        '${time.hour}:${time.minute} on ${scheduledTime.year}-${scheduledTime.month}-${scheduledTime.day}';
    scheduledNotifications.add('Reminder to drink water at $notificationTime');
    notifyListeners();
  }

  Future<void> scheduleNotifications(List<TimeOfDay> times) async {
    for (int i = 0; i < times.length; i++) {
      await showNotificationWithAction(i, times[i]);
    }
  }
}