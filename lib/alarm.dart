import 'package:flutter/services.dart';

class AlarmService {
  static const _alarm = MethodChannel('com.github.GeekCampVol7team38.latify/alarm');

  static Future<void> setAlarm(int hour, int minute) async {
    try {
      await _alarm.invokeMethod('setAlarm', {'hour': hour, 'minute': minute});
    } on PlatformException catch (_) {
    }
  }
}
