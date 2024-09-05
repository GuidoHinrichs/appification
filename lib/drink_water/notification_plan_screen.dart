import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'notification_service.dart';
import 'notification_card.dart';

class NotificationPlanScreen extends StatefulWidget {
  final double calculatedIntake;

  const NotificationPlanScreen({super.key, required this.calculatedIntake});

  @override
  NotificationPlanScreenState createState() => NotificationPlanScreenState();
}

class NotificationPlanScreenState extends State<NotificationPlanScreen> {
  late List<TimeOfDay> notificationTimes;
  late List<bool> isActiveList;
  final DateTime _today = DateTime.now();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  late final NotificationService _notificationService;

  @override
  void initState() {
    super.initState();

    _notificationService = NotificationService(
      flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
    );

    notificationTimes = calculateNotificationTimes(widget.calculatedIntake);
    isActiveList = List<bool>.filled(notificationTimes.length, true);
    _scheduleNotifications();
  }

  List<TimeOfDay> calculateNotificationTimes(double intake) {
    int numberOfNotifications = (intake / 0.25).round();
    List<TimeOfDay> times = [];
    double interval = (12.0 * 60) / numberOfNotifications;
    TimeOfDay start = const TimeOfDay(hour: 8, minute: 0);

    for (int i = 0; i < numberOfNotifications; i++) {
      times.add(start);
      start = start.replacing(
        hour: (start.hour + ((start.minute + interval) ~/ 60)) % 24,
        minute: (start.minute + interval.toInt()) % 60,
      );
    }
    return times;
  }

  void _scheduleNotifications() {
    if (_notificationService.scheduledNotifications.isEmpty) {
      for (int i = 0; i < notificationTimes.length; i++) {
        if (isActiveList[i]) {
          _notificationService.showNotificationWithAction(
              i, notificationTimes[i]);
        }
      }
    } else {
      debugPrint("Benachrichtigungen wurden bereits geplant.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final String formattedDate = "${_today.day}.${_today.month}.${_today.year}";

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Trink Wasser!',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: theme.colorScheme.primary,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      /*appBar: AppBar(
        title: Text('Benachrichtigungsplan - $formattedDate'),
      ),*/
      //body: NotificationList(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: notificationTimes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                        'Notification um ${notificationTimes[index].format(context)}'),
                    trailing: SizedBox(
                      width: 140,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isActiveList[index] = !isActiveList[index];
                            if (isActiveList[index]) {
                              _notificationService.showNotificationWithAction(
                                  index, notificationTimes[index]);
                            } else {
                              print(
                                  'Notification deaktiviert für ${notificationTimes[index]}');
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isActiveList[index]
                              ? theme.colorScheme.errorContainer
                              : theme.colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Text(
                          isActiveList[index] ? 'Deaktivieren' : 'Aktivieren',
                          style: TextStyle(
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationList(),
                    ),
                  );
                },
                child: const Text('Show Notifications'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
