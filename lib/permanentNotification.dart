import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PermanentNotification {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  static const NOTIFICATION_CHANNNEL = MethodChannel('com.github.GikuCampVol7team38.latify/notification');

  PermanentNotification(this.flutterLocalNotificationsPlugin);

  Future<void> showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
        '通知のスヌーズ', '一番上の通知をスヌーズします',
        importance: Importance.max,
        priority: Priority.high,
        ongoing: true, // これで通知はキルできないように設定(してるはずなんだけどなぁ)
        actions: <AndroidNotificationAction>[
          AndroidNotificationAction('key1', '5 分遅らせ'),
          AndroidNotificationAction('key2', '10 分遅らせ'),
          AndroidNotificationAction('key3', '1 時間遅らせ'),
        ]
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
        0, 'Notification title', 'Notification body', platformChannelSpecifics,
        payload: 'item x');
  }

  Future<void> _handleNotificationAction(String action) async {
    try {
      await NOTIFICATION_CHANNNEL.invokeMethod('handleAction', {"action": action});
    } on PlatformException catch (e) {
      print("Failed to handle action: '${e.message}'.");
    }
  }
}
