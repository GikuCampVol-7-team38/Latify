import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PermanentNotification {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  PermanentNotification(this.flutterLocalNotificationsPlugin);

  Future<void> showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
        'your_channel_id', 'your_channel_name',
        importance: Importance.max,
        priority: Priority.high,
        ongoing: true, // これで通知はキルできないように設定(してるはずなんだけどなぁ)
        actions: <AndroidNotificationAction>[
          AndroidNotificationAction('key1', 'Button 1'),
          AndroidNotificationAction('key2', 'Button 2'),
        ]
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
        0, 'Notification title', 'Notification body', platformChannelSpecifics,
        payload: 'item x');
  }
}
