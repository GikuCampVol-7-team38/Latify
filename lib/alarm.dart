import 'package:flutter/services.dart';

class AlarmService {
  static const platform = MethodChannel('com.github.GeekCampVol7team38.latify/alarm');

  static Future<void> setAlarm(int hour, int minute) async {
    try {
      await platform.invokeMethod('setAlarm', {'hour': hour, 'minute': minute});
    } on PlatformException catch (_) {
    }
  }
}
