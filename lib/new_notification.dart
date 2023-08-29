import 'package:flutter/services.dart';

import 'notification_data.dart';

class NewNotification{
  static const _notificationReceiver = MethodChannel('com.github.GeekCampVol7team38.latify/notificationReceiver');

  static Future<bool> isEmpty() {
    try {
      return _notificationReceiver.invokeMethod('getAvailableNotification').then((value) {
        if (value is List<String>) {
          return value.isEmpty;
        }
        return true;
      });
    } on PlatformException catch (_) {
      return Future.value(true);
    }
  }

  static Future<Iterable<String>?> getList() {
    try {
      return _notificationReceiver.invokeMethod('getAvailableNotification').then((value) {
        if (value is List<Object?>) {
          return value.whereType<String>();
        }
        return null;
      });
    } on PlatformException catch (_) {
      return Future.value(null);
    }
  }

  static Future<NotificationData?> peek(String notificationGuid) {
    try {
      return _notificationReceiver.invokeMethod('getNotificationDetail', {'fileName': notificationGuid }).then((value) {
        if (value is Map<Object?, Object?>) {
          return NotificationData.fromMap(value);
        }
        return null;
      });
    } on PlatformException catch (_) {
      return Future.value(null);
    }
  }

  static Future<NotificationData?> pop(String notificationGuid) async {
    try {
      final result = await peek(notificationGuid);
      await delete(notificationGuid);
      return result;
    } on PlatformException catch (_) {
      return Future.value(null);
    }
  }

  static Future<bool> delete(String notificationGuid) {
    try {
      return _notificationReceiver.invokeMethod('deleteNotification', {'fileName': notificationGuid }).then((value) {
        if (value is bool) {
          return value;
        }
        return false;
      });
    } on PlatformException catch (_) {
      return Future.value(false);
    }
  }
}
