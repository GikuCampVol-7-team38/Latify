import 'package:flutter/services.dart';

import 'marshalling_data.dart';

class NotificationData {
  static const _packageManager = MethodChannel('com.github.GeekCampVol7team38.latify/packageManager');

  final StatusBarNotification statusBarNotification;
  String? _appLabel;

  NotificationData(this.statusBarNotification);

  String getAppLabel() {
    if (_appLabel != null) {
      return _appLabel as String;
    }
    if (statusBarNotification.getPackageName != null) {
      return statusBarNotification.getPackageName as String;
    }
    return '';
  }

  Map<String, Object?>? toMap() {
    return {
    'statusBarNotification' : statusBarNotification.toMap(),
    'appLabel' : _appLabel,
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
    return NotificationData(statusBarNotification)
      .._appLabel = map['appLabel'];
  }

  static NotificationData? fromMap(Map<Object?, Object?>? map) {
    if (map == null) {
      return null;
    }
    final statusBarNotification = StatusBarNotification
    .fromMap(map['statusBarNotification'] is Map<Object?, Object?> ? map['statusBarNotification'] as Map<Object?, Object?> : null);
    if (statusBarNotification == null) {
      return null;
    }
    return NotificationData(statusBarNotification)
      .._appLabel = map['appLabel'] is String ? map['appLabel'] as String : null;
  }
}
