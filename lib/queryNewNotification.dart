import 'package:flutter/services.dart';

import 'marshallingData.dart' as marshalling_data;

class QueryNewNotification{
  static const _platform = MethodChannel('com.github.GeekCampVol7team38.latify/notificationReceiver');

  static Future<bool> hasNewNotification() {
    try {
      return _platform.invokeMethod('getAvailableNotification').then((value) {
        if (value is List<String>) {
          return value.isNotEmpty;
        }
        return false;
      });
    } on PlatformException catch (_) {
      return Future.value(false);
    }
  }

  static Future<Iterable<String>?> getNewNotificationList() {
    try {
      return _platform.invokeMethod('getAvailableNotification').then((value) {
        if (value is List<Object?>) {
          return value
              .whereType<String>()
              .map((item) => item!);
        }
        return null;
      });
    } on PlatformException catch (_) {
      return Future.value(null);
    }
  }

  static Future<marshalling_data.StatusBarNotification?> peekNewNotification(String notificationGuid) {
    try {
      return _platform.invokeMethod('getNotificationDetail', {"fileName": notificationGuid }).then((value) {
        if (value is Map<String, dynamic>) {
          return _parseNotification(value);
        }
        return null;
      });
    } on PlatformException catch (_) {
      return Future.value(null);
    }
  }

  static Future<marshalling_data.StatusBarNotification?> popNewNotification(String notificationGuid) async {
    try {
      final result = await peekNewNotification(notificationGuid);
      await clearNewNotification(notificationGuid);
      return result;
    } on PlatformException catch (_) {
      return Future.value(null);
    }
  }

  static Future<bool> clearNewNotification(String notificationGuid) {
    try {
      return _platform.invokeMethod('deleteNotification', notificationGuid).then((value) {
        if (value is bool) {
          return value;
        }
        return false;
      });
    } on PlatformException catch (_) {
      return Future.value(false);
    }
  }

  static marshalling_data.StatusBarNotification? _parseNotification(Map<String, dynamic> data) {
    marshalling_data.Notification notification = marshalling_data.Notification();
    notification.audioStreamType = data['notification.audioStreamType'];
    notification.category = data['notification.category'];
    notification.color = data['notification.color'];
    notification.defaults = data['notification.defaults'];
    notification.flags= data['notification.flags'];
    notification.icon = data['notification.icon'];
    notification.iconLevel = data['notification.iconLevel'];
    notification.ledARGB = data['notification.ledARGB'];
    notification.ledOffMS = data['notification.ledOffMS'];
    notification.ledOnMS = data['notification.ledOnMS'];
    notification.number = data['notification.number'];
    notification.priority = data['notification.priority'];
    notification.tickerText = marshalling_data.CharSequence().value = data['notification.tickerText'];
    notification.vibrate = data['notification.vibrate'];
    notification.visibility = data['notification.visibility'];
    notification.when = data['notification.when'];
    notification.describeContents = data['notification.describeContents'];
    notification.getAllowSystemGeneratedContextualActions = data['notification.getAllowSystemGeneratedContextualActions'];
    notification.getBadgeIconType = data['notification.getBadgeIconType'];
    notification.getChannelId = data['notification.getChannelId'];
    notification.getGroup = data['notification.getGroup'];
    notification.getGroupAlertBehavior = data['notification.getGroupAlertBehavior'];
    notification.getSettingsText = marshalling_data.CharSequence().value = data['notification.getSettingsText'];
    notification.getShortcutId = data['notification.getShortcutId'];
    notification.getSortKey = data['notification.getSortKey'];
    notification.getTimeoutAfter = data['notification.getTimeoutAfter'];
    notification.hasImage = data['notification.hasImage'];
    notification.notificationToString = data['notification.notificationToString'];

    marshalling_data.UserHandle userHandle = marshalling_data.UserHandle();
    userHandle.describeContents = data['userHandle.describeContents'];
    userHandle.userHandleHashCode = data['userHandle.hashCode'];
    userHandle.userHandleToString = data['userHandle.toString'];

    marshalling_data.StatusBarNotification statusBarNotification = marshalling_data.StatusBarNotification();
    statusBarNotification.describeContents = data['describeContents'];
    statusBarNotification.getGroupKey = data['getGroupKey'];
    statusBarNotification.getId = data['getId'];
    statusBarNotification.getKey = data['getKey'];
    statusBarNotification.getNotification = notification;
    statusBarNotification.getOpPkg = data['getOpPkg'];
    statusBarNotification.getOverrideGroupKey = data['getOverrideGroupKey'];
    statusBarNotification.getPackageName = data['getPackageName'];
    statusBarNotification.getPostTime = data['getPostTime'];
    statusBarNotification.getTag = data['getTag'];
    statusBarNotification.getUid = data['getUid'];
    statusBarNotification.getUserId = data['getUserId'];
    statusBarNotification.isAppGroup = data['isAppGroup'];
    statusBarNotification.isClearable = data['isClearable'];
    statusBarNotification.isGroup = data['isGroup'];
    statusBarNotification.isOngoing = data['isOngoing'];
    statusBarNotification.statusBarNotificationToString = data['toString'];

    return statusBarNotification;
  }
}