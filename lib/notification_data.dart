import 'marshalling_data.dart';

class NotificationData {
  final StatusBarNotification statusBarNotification;

  NotificationData(this.statusBarNotification);

  Map<String, Object?>? toMap() {
    return {
    'statusBarNotification' : statusBarNotification.toMap(),
    };
  }

  static NotificationData? fromDynamic(dynamic map) {
    if (map is! Map<dynamic, dynamic>) {
      return null;
    }
    final statusBarNotification = StatusBarNotification.fromDynamic(map['statusBarNotification']);
    if (statusBarNotification == null) {
      return null;
    }
    return NotificationData(statusBarNotification);
  }

  static NotificationData? fromMap(Map<Object?, Object?>? map) {
    if (map == null) {
      return null;
    }
    final statusBarNotification = StatusBarNotification.fromMap(map['statusBarNotification'] is Map<Object?, Object?> ? map['statusBarNotification'] as Map<Object?, Object?> : null);
    if (statusBarNotification == null) {
      return null;
    }
    return NotificationData(statusBarNotification);
  }
}
