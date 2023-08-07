package com.github.GikuCampVol7team38.latify

import android.app.AlarmManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.os.Bundle;
import android.provider.AlarmClock
import android.provider.Settings
import androidx.annotation.NonNull
import java.io.File
import org.msgpack.core.MessagePack
import org.msgpack.core.MessageBufferPacker
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val LIFECYCLE = "com.github.GeekCampVol7team38.latify/lifecycle"
    private val ALARM_CHANNEL = "com.github.GeekCampVol7team38.latify/alarm"
    private val NOTIFICATION_ACCESS_CHANNEL = "com.github.GeekCampVol7team38.latify/notification_access"
    private val NOTIFICATION_RECEIVER = "com.github.GeekCampVol7team38.latify/notificationReceiver"
    private val NOTIFICATION_CHANNNEL = "com.github.GikuCampVol7team38.latify/notification";
    private val STORAGE_CHANNNEL = "com.github.GeekCampVol7team38.latify/storage";

    private lateinit var lifecycleMethodChannel: MethodChannel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val flutterEngine = FlutterEngine(this)
        lifecycleMethodChannel = MethodChannel(flutterEngine.dartExecutor, LIFECYCLE)
        lifecycleMethodChannel.invokeMethod("activityResumed", null)
    }

    override fun onResume() {
        super.onResume()

        lifecycleMethodChannel.invokeMethod("activityResumed", null)
    }

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

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, NOTIFICATION_RECEIVER).setMethodCallHandler {
                call, result ->
            when (call.method) {
                "getAvailableNotification" -> {
                    val directory = File(this.filesDir, "raw")
                    if (directory.exists()) {
                        val fileNames = directory.listFiles()?.map { it.name } ?: listOf()
                        result.success(fileNames)
                    } else {
                        result.success(null)
                    }
                }

                "getNotificationDetail" -> {
                    val fileName = call.argument<String>("fileName") ?: ""
                    val file = File(this.filesDir, "raw/$fileName")
                    if (file.exists()) {
                        val unpacker = MessagePack.newDefaultUnpacker(file.readBytes())

                        val mapSize = unpacker.unpackMapHeader()
                        val resultMap = hashMapOf<String, Any?>()

                        for (i in 0 until mapSize) {
                            val key = unpacker.unpackString()

                            val value = when (unpacker.getNextFormat()) {
                                org.msgpack.core.MessageFormat.BOOLEAN -> unpacker.unpackBoolean()
                                org.msgpack.core.MessageFormat.STR8 -> unpacker.unpackString()
                                org.msgpack.core.MessageFormat.STR16 -> unpacker.unpackString()
                                org.msgpack.core.MessageFormat.FIXSTR -> unpacker.unpackString()
                                org.msgpack.core.MessageFormat.INT32 -> unpacker.unpackInt()
                                org.msgpack.core.MessageFormat.INT64 -> unpacker.unpackLong()
                                org.msgpack.core.MessageFormat.FLOAT32 -> unpacker.unpackFloat()
                                org.msgpack.core.MessageFormat.FLOAT64 -> unpacker.unpackDouble()
                                org.msgpack.core.MessageFormat.POSFIXINT -> unpacker.unpackInt()
                                org.msgpack.core.MessageFormat.NEGFIXINT -> unpacker.unpackInt()
                                org.msgpack.core.MessageFormat.UINT16 -> unpacker.unpackInt()
                                org.msgpack.core.MessageFormat.UINT32 -> unpacker.unpackLong()
                                org.msgpack.core.MessageFormat.UINT64 -> unpacker.unpackLong()
                                org.msgpack.core.MessageFormat.NIL -> {
                                    unpacker.unpackNil()
                                    null
                                }
                                else -> unpacker.skipValue()
                            }
                            resultMap[key] = value
                        }

                        result.success(resultMap)
                    } else {
                        result.success(null)
                    }
                }

                "deleteNotification" -> {
                    val fileName = call.argument<String>("fileName") ?: ""
                    val file = File(this.filesDir, "raw/$fileName")
                    if (file.exists()) {
                        file.delete()
                        result.success(true)
                    } else {
                        result.success(false)
                    }
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

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, STORAGE_CHANNNEL).setMethodCallHandler {
                call, result ->
            when (call.method) {
                "read" -> {
                    val fileName = call.argument<String>("fileName") ?: ""
                    val file = File(this.filesDir, fileName)
                    if (file.exists()) {
                        val bytes = file.readBytes()
                        result.success(bytes)
                    } else {
                        result.success(null)
                    }
                }

                "write" -> {
                    val fileName = call.argument<String>("fileName") ?: ""
                    val bytes = call.argument<ByteArray>("bytes") ?: byteArrayOf()
                    val file = File(this.filesDir, fileName)
                    file.writeBytes(bytes)
                    result.success(null)
                }

                "delete" -> {
                    val fileName = call.argument<String>("fileName") ?: ""
                    val file = File(this.filesDir, fileName)
                    if (file.exists()) {
                        file.delete()
                        result.success(true)
                    } else {
                        result.success(false)
                    }
                }

                "exists" -> {
                    val fileName = call.argument<String>("fileName") ?: ""
                    val file = File(this.filesDir, fileName)
                    result.success(file.exists())
                }

                else -> result.notImplemented()
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
