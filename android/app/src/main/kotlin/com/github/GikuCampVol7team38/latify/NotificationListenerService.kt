package com.github.GikuCampVol7team38.latify

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.os.Build
import android.service.notification.NotificationListenerService
import android.service.notification.StatusBarNotification
import androidx.core.app.NotificationCompat
import java.io.File
import java.util.UUID
import org.msgpack.core.MessagePack
import org.msgpack.core.MessageBufferPacker
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MyNotificationListenerService : NotificationListenerService() {
    private val CHANNEL_ID = "MyChannel"

    override fun onNotificationPosted(sbn: StatusBarNotification?) {
        super.onNotificationPosted(sbn)

        val packageName = sbn?.packageName?.toString() ?: ""

        if (packageName == "com.github.GikuCampVol7team38.latify") {
            return
        }

        val map = hashMapOf<String, Any?>(
            // int: Describe the kinds of special objects contained in this Parcelable instance's marshaled representation.
            "describeContents" to sbn?.describeContents(),
            // String: A key that indicates the group with which this message ranks.
            "getGroupKey" to sbn?.getGroupKey(),
            // int: The id supplied to NotificationManager.notify(int, Notification).
            "getId" to sbn?.getId(),
            // String: A unique instance key for this notification record.
            "getKey" to sbn?.getKey(),
            // Notification: The Notification supplied to NotificationManager.notify(int, Notification).
            // Action[]: Array of all Action structures attached to this notification by Builder#addAction(int, CharSequence, PendingIntent).

            // AudioAttributes: This field was deprecated in API level 26. use NotificationChannel#getAudioAttributes() instead.

            // int: This field was deprecated in API level 21. Use audioAttributes instead.
            "notification.audioStreamType" to sbn?.notification?.audioStreamType,
            // RemoteViews: A large-format version of contentView, giving the Notification an opportunity to show more detail.

            // String: One of the predefined notification categories (see the CATEGORY_* constants) that best describes this Notification.
            "notification.category" to sbn?.notification?.category,
            // int: Accent color (an ARGB integer like the constants in Color) to be applied by the standard Style templates when presenting this notification.
            "notification.color" to sbn?.notification?.color,
            // PendingIntent: The intent to execute when the expanded status entry is clicked.

            // RemoteViews: The view that will represent this notification in the notification list (which is pulled down from the status bar).

            // int: This field was deprecated in API level 26. use NotificationChannel#getSound() and NotificationChannel#shouldShowLights() and NotificationChannel#shouldVibrate().
            "notification.defaults" to sbn?.notification?.defaults,
            // PendingIntent: The intent to execute when the notification is explicitly dismissed by the user, either with the "Clear All" button or by swiping it away individually.

            // BUndle: Additional semantic data to be carried around with this Notification.

            // int
            "notification.flags" to sbn?.notification?.flags,
            // PendingIntent: An intent to launch instead of posting the notification to the status bar.

            // RemoteViews: A medium-format version of contentView, providing the Notification an opportunity to add action buttons to contentView.

            // int: This field was deprecated in API level 23. Use Builder#setSmallIcon(Icon) instead.
            "notification.icon" to sbn?.notification?.icon,
            // int: If the icon in the status bar is to have more than one level, you can set this.
            "notification.iconLevel" to sbn?.notification?.iconLevel,
            // Bitmap: This field was deprecated in API level 23. Use Builder#setLargeIcon(Icon) instead.

            // int: This field was deprecated in API level 26. use NotificationChannel#shouldShowLights().
            "notification.ledARGB" to sbn?.notification?.ledARGB,
            // int: This field was deprecated in API level 26. use NotificationChannel#shouldShowLights().
            "notification.ledOffMS" to sbn?.notification?.ledOffMS,
            // int: This field was deprecated in API level 26. use NotificationChannel#shouldShowLights().
            "notification.ledOnMS" to sbn?.notification?.ledOnMS,
            // int: The number of events that this notification represents.
            "notification.number" to sbn?.notification?.number,
            // int: This field was deprecated in API level 26. use NotificationChannel#getImportance() instead.
            "notification.priority" to sbn?.notification?.priority,
            // Notification: This field was deprecated in API level 26. use NotificationChannel#getImportance() instead.

            // Uri: This field was deprecated in API level 26. use NotificationChannel#getSound().

            // CharSequence: Text that summarizes this notification for accessibility services.
            "notification.tickerText" to sbn?.notification?.tickerText?.toString(),
            // RemoteViews: Formerly, a view showing the tickerText.

            // long[]: This field was deprecated in API level 26. use NotificationChannel#getVibrationPattern().
            "notification.vibrate" to sbn?.notification?.vibrate,
            // int: Sphere of visibility of this notification, which affects how and when the SystemUI reveals the notification's presence and contents in untrusted situations (namely, on the secure lockscreen).
            "notification.visibility" to sbn?.notification?.visibility,
            // long: A timestamp related to this notification, in milliseconds since the epoch.
            "notification.when" to sbn?.notification?.`when`,
            // int: Describe the kinds of special objects contained in this Parcelable instance's marshaled representation.
            "notification.describeContents" to sbn?.notification?.describeContents(),
            // Pair<RemoteInput[], Notification.Action[]>: Finds and returns a remote input and its corresponding action.

            // boolean: Returns whether the platform is allowed (by the app developer) to generate contextual actions for this notification.
            "notification.getAllowSystemGeneratedContextualActions" to sbn?.notification?.getAllowSystemGeneratedContextualActions(),
            // int: Returns what icon should be shown for this notification if it is being displayed in a Launcher that supports badging.
            "notification.getBadgeIconType" to sbn?.notification?.getBadgeIconType(),
            // Notification.BubbleMetadata: Returns the bubble metadata that will be used to display app content in a floating window over the existing foreground activity.

            // String: Returns the id of the channel this notification posts to.
            "notification.getCannelId" to sbn?.notification?.getChannelId(),
            // List<Notification.Action>: Returns the actions that are contextual (that is, suggested because of the content of the notification) out of the actions in this notification.

            // String: Get the key used to group this notification into a cluster or stack with other notifications on devices which support such rendering.
            "notification.getGroup" to sbn?.notification?.getGroup(),
            // int: Returns which type of notifications in a group are responsible for audibly alerting the user.
            "notification.getGroupAlertBehavior" to sbn?.notification?.getGroupAlertBehavior(),
            // Icon: The large icon shown in this notification's content view.

            // LocusId: Gets the LocusId associated with this notification.

            // CharSequence: Returns the settings text provided to Builder#setSettingsText(CharSequence).
            "notification.getSettingsText" to sbn?.notification?.getSettingsText()?.toString(),
            // String: Returns the id that this notification supersedes, if any.
            "notification.getShortcutId" to sbn?.notification?.getShortcutId(),
            // Icon: The small icon representing this notification in the status bar and content view.

            // String: Get a sort key that orders this notification among other notifications from the same package.
            "notification.getSortKey" to sbn?.notification?.getSortKey(),
            // long: Returns the duration from posting after which this notification should be canceled by the system, if it's not canceled already.
            "notification.getTimeoutAfter" to sbn?.notification?.getTimeoutAfter(),
            // boolean
            "notification.hasImage" to sbn?.notification?.hasImage(),
            // String: Returns a string representation of the object.
            "notification.toString" to sbn?.notification?.toString(),
            // String: The package that posted the notification.
            "OpPkg" to sbn?.opPkg,
            // String: Returns the override group key.
            "getOverrideGroupKey" to sbn?.getOverrideGroupKey(),
            // String: The package that the notification belongs to.
            "getPackageName" to sbn?.getPackageName(),
            // long: The time (in System#currentTimeMillis time) the notification was posted, which may be different than Notification.when.
            "getPostTime" to sbn?.getPostTime(),
            // String: The tag supplied to NotificationManager.notify(int, Notification), or null if no tag was specified.
            "getTag" to sbn?.getTag(),
            // int: The notifying app's (getPackageName()'s) uid.
            "getUid" to sbn?.getUid(),
            // UserHandle: The UserHandle for whom this notification is intended.
            // int: Describe the kinds of special objects contained in this Parcelable instance's marshaled representation.
            "user.describeContents" to sbn?.user?.describeContents(),
            // int: Returns a hash code value for the object.
            "user.hashCode" to sbn?.user?.hashCode(),
            // String: Returns a string representation of the object.
            "user.toString" to sbn?.user?.toString(),
            // int: This method was deprecated in API level 21. Use getUser() instead.
            "getUserId" to sbn?.getUserId(),
            // boolean: Returns true if application asked that this notification be part of a group.
            "isAppGroup" to sbn?.isAppGroup,
            // boolean: Convenience method to check the notification's flags for either Notification#FLAG_ONGOING_EVENT or Notification#FLAG_NO_CLEAR.
            "isClearable" to sbn?.isClearable,
            // boolean: Returns true if this notification is part of a group.
            "isGroup" to sbn?.isGroup,
            // boolean: Convenience method to check the notification's flags for Notification#FLAG_ONGOING_EVENT.
            "isOngoing" to sbn?.isOngoing,
            // String: Returns a string representation of the object.
            "toString" to sbn?.toString(),
        )

        val packer: MessageBufferPacker = MessagePack.newDefaultBufferPacker()

        packer.packMapHeader(map.size)

        for ((key, value) in map) {
            packer.packString(key)
            when (value) {
                null -> packer.packNil()
                is Boolean -> packer.packBoolean(value)
                is Byte -> packer.packByte(value)
                is Short -> packer.packShort(value)
                is Int -> packer.packInt(value)
                is Long -> packer.packLong(value)
                is Float -> packer.packFloat(value)
                is Double -> packer.packDouble(value)
                is String -> packer.packString(value)
                is ByteArray -> packer.packBinaryHeader(value.size).writePayload(value)
                is List<*> -> {
                    packer.packArrayHeader(value.size)
                    for (item in value) {
                        when (item) {
                            null -> packer.packNil()
                            is Boolean -> packer.packBoolean(item)
                            is Byte -> packer.packByte(item)
                            is Short -> packer.packShort(item)
                            is Int -> packer.packInt(item)
                            is Long -> packer.packLong(item)
                            is Float -> packer.packFloat(item)
                            is Double -> packer.packDouble(item)
                            is String -> packer.packString(item)
                            is ByteArray -> packer.packBinaryHeader(item.size).writePayload(item)
                            else -> throw Exception("Unsupported type: ${item::class.java}")
                        }
                    }
                }
                else -> throw Exception("Unsupported type: ${value::class.java}")
            }
        }

        val rawNotificationFolder = File(this.filesDir, "raw")

        if (!rawNotificationFolder.exists()) {
            rawNotificationFolder.mkdir()
        }

        val file = File(rawNotificationFolder, UUID.randomUUID().toString())
        file.writeBytes(packer.toByteArray())

        val notification = sbn?.notification

        sendMyNotification(packageName, notification)
    }

    private fun sendMyNotification(packageName: String, notification: Notification?) {
        if (notification == null) {
            return
        }

        val notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

        // Create Notification Channel for Android O and above
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val name = "My Notification Channel"
            val descriptionText = "This is my own notification channel"
            val importance = NotificationManager.IMPORTANCE_DEFAULT
            val channel = NotificationChannel(CHANNEL_ID, name, importance).apply {
                description = descriptionText
            }
            notificationManager.createNotificationChannel(channel)
        }

        val delayBy5minutesIntent = Intent(this, DelayBy5MinutesReciever::class.java)
        val delayBy5minutesPendingIntent = PendingIntent.getBroadcast(this, 0, delayBy5minutesIntent, PendingIntent.FLAG_IMMUTABLE)

        val delayBy10minutesIntent = Intent(this, DelayBy10MinutesReciever::class.java)
        val delayBy10minutesPendingIntent = PendingIntent.getBroadcast(this, 0, delayBy10minutesIntent, PendingIntent.FLAG_IMMUTABLE)

        val delayBy60minutesIntent = Intent(this, DelayBy60MinutesReciever::class.java)
        val delayBy60minutesPendingIntent = PendingIntent.getBroadcast(this, 0, delayBy60minutesIntent, PendingIntent.FLAG_IMMUTABLE)

        val builder = NotificationCompat.Builder(this, CHANNEL_ID)
            .setContentTitle("New notification from $packageName")
            .setContentText(notification.tickerText)
            .setSmallIcon(R.mipmap.ic_launcher)
            .addAction(R.mipmap.ic_launcher, "Delay by 5 minutes", delayBy5minutesPendingIntent)
            .addAction(R.mipmap.ic_launcher, "Delay by 10 minutes", delayBy10minutesPendingIntent)
            .addAction(R.mipmap.ic_launcher, "Delay by an hour", delayBy60minutesPendingIntent)
            .setOngoing(true)

        notificationManager.notify(1, builder.build())
    }

    override fun onNotificationRemoved(sbn: StatusBarNotification?) {
        super.onNotificationRemoved(sbn)
        // Handle notification when posted
    }
}
