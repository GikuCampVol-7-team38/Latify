package com.github.GikuCampVol7team38.latify

import android.app.AlarmManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Bundle
import android.provider.AlarmClock
import android.provider.Settings
import androidx.annotation.NonNull
import java.io.File
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val LIFECYCLE_CHANNEL = "com.github.GeekCampVol7team38.latify/lifecycle"
    private val ALARM_CHANNEL = "com.github.GeekCampVol7team38.latify/alarm"
    private val NOTIFICATION_ACCESS_CHANNEL = "com.github.GeekCampVol7team38.latify/notification_access"
    private val NOTIFICATION_RECEIVER = "com.github.GeekCampVol7team38.latify/notificationReceiver"
    private val NOTIFICATION_CHANNNEL = "com.github.GikuCampVol7team38.latify/notification";
    private val STORAGE_CHANNNEL = "com.github.GeekCampVol7team38.latify/storage";
    private val PACKAGE_MANAGER_CHANNNEL = "com.github.GeekCampVol7team38.latify/packageManager";
    private val NOTION_CHANNNEL = "com.github.GeekCampVol7team38.latify/notion";

    private lateinit var lifecycleMethodChannel: MethodChannel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val flutterEngine = FlutterEngine(this)
        lifecycleMethodChannel = MethodChannel(flutterEngine.dartExecutor, LIFECYCLE_CHANNEL)
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
                        result.success(MyMessagePack.unpack(file.readBytes()))
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

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, PACKAGE_MANAGER_CHANNNEL).setMethodCallHandler {
                call, result ->
            when (call.method) {
                "getAppLabel" -> {
                    val packageName = call.argument<String>("packageName") ?: ""

                    if (packageName == "") {
                        result.success(null)
                        return@setMethodCallHandler
                    }

                    val appInfo = packageManager.getApplicationInfo(packageName, PackageManager.GET_META_DATA)
                    val appLabel = packageManager.getApplicationLabel(appInfo).toString()
                    result.success(appLabel)
                }
                else -> result.notImplemented()
            }
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, NOTION_CHANNNEL).setMethodCallHandler {
                call, result ->
            when (call.method) {
                "send" -> {
                    val json = call.argument<String>("json") ?: ""
                    val databaseKey = call.argument<String>("databaseKey") ?: ""
                    val connectTimeoutMillis = call.argument<Int>("connectTimeoutMillis") ?: 5000
                    val readTimeoutMillis = call.argument<Int>("readTimeoutMillis") ?: 15000
                    val success = NotionTerminal.send(
                        NotionData.load(this),
                        json,
                        databaseKey,
                        connectTimeoutMillis,
                        readTimeoutMillis,
                        { b -> result.success(b)}
                    )
                }
                "setApiKey" ->{
                    val apiKey = call.argument<String>("apiKey") ?: ""
                    if (apiKey == "") {
                        result.success(null)
                        return@setMethodCallHandler
                    }
                    val notionData = NotionData.load(this)
                    notionData.ApiKey = apiKey
                    notionData.save(this)
                    result.success(true)
                }
                "setDatabaseID" ->{
                    val databaseID = call.argument<String>("databaseID") ?: ""
                    val databaseKey = call.argument<String>("databaseKey") ?: ""
                    if (databaseID == "" || databaseKey == "") {
                        result.success(false)
                        return@setMethodCallHandler
                    }
                    val notionData = NotionData.load(this)
                    notionData.databaseIDMap[databaseKey] = databaseID
                    notionData.save(this)
                    result.success(true)
                }
                "getApiKey" ->{
                    val notionData = NotionData.load(this)
                    result.success(notionData.ApiKey)
                }
                "getDatabaseID" ->{
                    val databaseKey = call.argument<String>("databaseKey") ?: ""
                    if (databaseKey == "") {
                        result.success("")
                        return@setMethodCallHandler
                    }
                    val notionData = NotionData.load(this)
                    result.success(notionData.databaseIDMap[databaseKey])
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
