package com.github.GikuCampVol7team38.latify

import android.app.AlarmManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.provider.AlarmClock
import android.provider.Settings
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val ALARM_CHANNEL = "com.github.GeekCampVol7team38.latify/alarm"
    private val NOTIFICATION_ACCESS_CHANNEL = "com.github.GeekCampVol7team38.latify/notification_access"
    private val NOTIFICATION_CHANNNEL = "com.github.GikuCampVol7team38.latify/notification";

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, ALARM_CHANNEL).setMethodCallHandler {
                call, result ->
            if (call.method == "setAlarm") {
                val hour = call.argument<Int>("hour") ?: 0
                val minute = call.argument<Int>("minute") ?: 0
                setAlarm(this, hour, minute)
                result.success("Alarm Set Successfully")
            } else {
                result.notImplemented()
            }
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, NOTIFICATION_ACCESS_CHANNEL).setMethodCallHandler {
                call, result ->
            when (call.method) {
                "requestNotificationAccess" -> {
                    val intent = Intent(Settings.ACTION_NOTIFICATION_LISTENER_SETTINGS)
                    startActivity(intent)
                    result.success(true)
                }
                "isNotificationAccessEnabled" -> {
                    result.success(isNotificationAccessEnabled())
                }
                else -> result.notImplemented()
            }
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, NOTIFICATION_CHANNNEL).setMethodCallHandler {
                call, result ->
            if (call.method == "handleAction") {
                val action: String? = call.argument("action")
                notificationAction(action)
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun setAlarm(context: Context, hour: Int, minute: Int) {
        val intent = Intent(AlarmClock.ACTION_SET_ALARM)
        intent.putExtra(AlarmClock.EXTRA_HOUR, hour)
        intent.putExtra(AlarmClock.EXTRA_MINUTES, minute)
        intent.putExtra(AlarmClock.EXTRA_SKIP_UI, true)
        context.startActivity(intent)
    }

    private fun isNotificationAccessEnabled(): Boolean {
        val enabledListeners = Settings.Secure.getString(contentResolver, "enabled_notification_listeners")
        val packageName = packageName
        return enabledListeners?.contains(packageName) == true
    }

    private fun notificationAction(action: String?) {
        when (action) {
            "key1" -> {
                // Button 1 の動作を実装する
            }

            "key2" -> {
                // Button 2 の動作を実装する
            }

            "key3" -> {
                // Button 3 の動作を実装する
            }

            else -> {
                // その他の動作を実装する
            }
        }
    }
}
