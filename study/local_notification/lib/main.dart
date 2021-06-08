import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() {
  _initNotiSetting();
  runApp(MyApp());
}

void _initNotiSetting() async {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final initSettingsAndroid = AndroidInitializationSettings('app_icon');
  final initSettingsIOS = IOSInitializationSettings(
    requestSoundPermission: false, // 앱 시작 후 바로 권한을 묻길 원할 경우 true로 변
    requestBadgePermission: false,
    requestAlertPermission: false,
  );
  final initSettings = InitializationSettings(
    android: initSettingsAndroid,
    iOS: initSettingsIOS,
  );
  await flutterLocalNotificationsPlugin.initialize(
    initSettings,
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Material App')),
        body: Container(
          child: ElevatedButton(
            onPressed: () {
              _sendNotification();
            },
            child: Text('Send Noti'),
          ),
        ),
      ),
    );
  }

  Future _sendNotification() async {
    final String title = 'title';
    final String description = 'description';

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final result = await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
    var android = AndroidNotificationDetails('id', title, description, importance: Importance.max, priority: Priority.max);
    var ios = IOSNotificationDetails();
    var detail = NotificationDetails(android: android, iOS: ios);

    if (result != null) {
      await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.deleteNotificationChannelGroup('id');
      await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        title,
        description,
        _setNotiTime(),
        detail,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
  }

  tz.TZDateTime _setNotiTime() {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Seoul'));

    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day,
        now.hour, now.minute + 1);

    return scheduledDate;
  }
}

