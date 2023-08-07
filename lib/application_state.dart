import 'notification_data.dart';

class ApplicationState {
  List<NotificationData> notificationList = [];

  Map<String, Object?>? toMap() {
    return {
    'notificationList' : notificationList.map((e) => e.toMap()).toList(),
    };
  }

  static ApplicationState? fromDynamic(dynamic map) {
    if (map is! Map<dynamic, dynamic>) {
      return null;
    }
    final notificationList = (map['notificationList'] is List<dynamic>)
        ? map['notificationList']
        .map((e) => NotificationData.fromDynamic(e))
        .whereType<NotificationData>()
        .toList()
        : null;

    if (notificationList == null) {
      return null;
    }
    return ApplicationState()
      ..notificationList = notificationList;
  }

  static ApplicationState? fromMap(Map<Object?, Object?>? map) {
    if (map == null) {
      return null;
    }
    final notificationList = (map['notificationList'] is List<Object?>)
        ? (map['notificationList'] as List<Object?>)
        .map((e) => NotificationData.fromMap(e is Map<Object?, Object?> ? e : null))
        .whereType<NotificationData>()
        .toList()
        : null;

    if (notificationList == null) {
      return null;
    }
    return ApplicationState()
      ..notificationList = notificationList;
  }
}
