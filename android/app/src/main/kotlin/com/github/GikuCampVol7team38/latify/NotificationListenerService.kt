package com.github.GikuCampVol7team38.latify

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.graphics.Bitmap
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.graphics.drawable.Icon
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import android.service.notification.NotificationListenerService
import android.service.notification.StatusBarNotification
import androidx.core.app.NotificationCompat
import androidx.core.content.ContextCompat
import java.io.ByteArrayOutputStream
import java.io.File
import java.text.SimpleDateFormat
import java.util.Date
import java.util.UUID
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
            "getNotification" to hashMapOf<String, Any?>(
                // Action[]: Array of all Action structures attached to this notification by Builder#addAction(int, CharSequence, PendingIntent).

                // AudioAttributes: This field was deprecated in API level 26. use NotificationChannel#getAudioAttributes() instead.

                // int: This field was deprecated in API level 21. Use audioAttributes instead.
                "audioStreamType" to sbn?.notification?.audioStreamType,
                // RemoteViews: A large-format version of contentView, giving the Notification an opportunity to show more detail.

                // String: One of the predefined notification categories (see the CATEGORY_* constants) that best describes this Notification.
                "category" to sbn?.notification?.category,
                // int: Accent color (an ARGB integer like the constants in Color) to be applied by the standard Style templates when presenting this notification.
                "color" to sbn?.notification?.color,
                // PendingIntent: The intent to execute when the expanded status entry is clicked.

                // RemoteViews: The view that will represent this notification in the notification list (which is pulled down from the status bar).

                // int: This field was deprecated in API level 26. use NotificationChannel#getSound() and NotificationChannel#shouldShowLights() and NotificationChannel#shouldVibrate().
                "defaults" to sbn?.notification?.defaults,
                // PendingIntent: The intent to execute when the notification is explicitly dismissed by the user, either with the "Clear All" button or by swiping it away individually.

                // BUndle: Additional semantic data to be carried around with this Notification.

                // int
                "flags" to sbn?.notification?.flags,
                // PendingIntent: An intent to launch instead of posting the notification to the status bar.

                // RemoteViews: A medium-format version of contentView, providing the Notification an opportunity to add action buttons to contentView.

                // int: This field was deprecated in API level 23. Use Builder#setSmallIcon(Icon) instead.
                "icon" to sbn?.notification?.icon,
                // int: If the icon in the status bar is to have more than one level, you can set this.
                "iconLevel" to sbn?.notification?.iconLevel,
                // Bitmap: This field was deprecated in API level 23. Use Builder#setLargeIcon(Icon) instead.

                // int: This field was deprecated in API level 26. use NotificationChannel#shouldShowLights().
                "ledARGB" to sbn?.notification?.ledARGB,
                // int: This field was deprecated in API level 26. use NotificationChannel#shouldShowLights().
                "ledOffMS" to sbn?.notification?.ledOffMS,
                // int: This field was deprecated in API level 26. use NotificationChannel#shouldShowLights().
                "ledOnMS" to sbn?.notification?.ledOnMS,
                // int: The number of events that this notification represents.
                "number" to sbn?.notification?.number,
                // int: This field was deprecated in API level 26. use NotificationChannel#getImportance() instead.
                "priority" to sbn?.notification?.priority,
                // Notification: This field was deprecated in API level 26. use NotificationChannel#getImportance() instead.

                // Uri: This field was deprecated in API level 26. use NotificationChannel#getSound().

                // CharSequence: Text that summarizes this notification for accessibility services.
                "tickerText" to hashMapOf<String, Any?>(
                    "value" to sbn?.notification?.tickerText?.toString(),
                ),
                // RemoteViews: Formerly, a view showing the tickerText.

                // long[]: This field was deprecated in API level 26. use NotificationChannel#getVibrationPattern().
                "vibrate" to sbn?.notification?.vibrate,
                // int: Sphere of visibility of this notification, which affects how and when the SystemUI reveals the notification's presence and contents in untrusted situations (namely, on the secure lockscreen).
                "visibility" to sbn?.notification?.visibility,
                // long: A timestamp related to this notification, in milliseconds since the epoch.
                "when" to sbn?.notification?.`when`,
                // int: Describe the kinds of special objects contained in this Parcelable instance's marshaled representation.
                "describeContents" to sbn?.notification?.describeContents(),
                // Pair<RemoteInput[], Notification.Action[]>: Finds and returns a remote input and its corresponding action.

                // boolean: Returns whether the platform is allowed (by the app developer) to generate contextual actions for this notification.
                "getAllowSystemGeneratedContextualActions" to sbn?.notification?.getAllowSystemGeneratedContextualActions(),
                // int: Returns what icon should be shown for this notification if it is being displayed in a Launcher that supports badging.
                "getBadgeIconType" to sbn?.notification?.getBadgeIconType(),
                // Notification.BubbleMetadata: Returns the bubble metadata that will be used to display app content in a floating window over the existing foreground activity.

                // String: Returns the id of the channel this notification posts to.
                "getCannelId" to sbn?.notification?.getChannelId(),
                // List<Notification.Action>: Returns the actions that are contextual (that is, suggested because of the content of the notification) out of the actions in this notification.

                // String: Get the key used to group this notification into a cluster or stack with other notifications on devices which support such rendering.
                "getGroup" to sbn?.notification?.getGroup(),
                // int: Returns which type of notifications in a group are responsible for audibly alerting the user.
                "getGroupAlertBehavior" to sbn?.notification?.getGroupAlertBehavior(),
                // Icon: The large icon shown in this notification's content view.
                "getLargeIcon" to getIconFromIcon(sbn?.notification?.getLargeIcon(), this),
                // LocusId: Gets the LocusId associated with this notification.

                // CharSequence: Returns the settings text provided to Builder#setSettingsText(CharSequence).
                "getSettingsText" to hashMapOf<String, Any?>(
                    "value" to sbn?.notification?.getSettingsText()?.toString(),
                ),
                // String: Returns the id that this notification supersedes, if any.
                "getShortcutId" to sbn?.notification?.getShortcutId(),
                // Icon: The small icon representing this notification in the status bar and content view.
                "getSmallIcon" to getIconFromIcon(sbn?.notification?.getSmallIcon(), this),
                // String: Get a sort key that orders this notification among other notifications from the same package.
                "getSortKey" to sbn?.notification?.getSortKey(),
                // long: Returns the duration from posting after which this notification should be canceled by the system, if it's not canceled already.
                "getTimeoutAfter" to sbn?.notification?.getTimeoutAfter(),
                // boolean
                "hasImage" to sbn?.notification?.hasImage(),
                // String: Returns a string representation of the object.
                "notificationToString" to sbn?.notification?.toString(),
                ),
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
            "getUser" to hashMapOf<String, Any?>(
                // int: Describe the kinds of special objects contained in this Parcelable instance's marshaled representation.
                "describeContents" to sbn?.user?.describeContents(),
                // int: Returns a hash code value for the object.
                "hashCode" to sbn?.user?.hashCode(),
                // String: Returns a string representation of the object.
                "userHandleToString" to sbn?.user?.toString(),
                ),
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
            "statusBarNotificationToString" to sbn?.toString(),
        )
        val rawNotificationFolder = File(this.filesDir, "raw")

        if (!rawNotificationFolder.exists()) {
            rawNotificationFolder.mkdir()
        }

        val file = File(rawNotificationFolder, UUID.randomUUID().toString())
        file.writeBytes(MyMessagePack.pack(map))

        val notification = sbn?.notification

        if (packageName != "") {
            val appInfo = packageManager.getApplicationInfo(packageName, PackageManager.GET_META_DATA)
            val appLabel = packageManager.getApplicationLabel(appInfo).toString()

            val notificationContent = "Notification Date: ${convertUnixMillisToFormattedDate(sbn?.getPostTime(), "yyyy-MM-dd HH:mm")}\\n\\n${sbn?.notification?.tickerText?.toString()}"
            sendMyNotification(appLabel, notification, notificationContent)

            NotionTerminal.send(
                NotionData.load(this),
                "\"properties\":{\"title\":{\"title\":[{\"text\":{\"content\":\"${appLabel}\"}}]}},\"children\":[{\"object\":\"block\",\"type\":\"paragraph\",\"paragraph\":{\"text\":[{\"type\":\"text\",\"text\":{\"content\":\"$notificationContent\"}}]}}]",
                "key",
                5000,
                15000,
                { _ -> {}}
            )
        }
    }

    private fun getIconFromIcon(icon: Icon?, context: Context): Map<String, Any?> {
        return hashMapOf<String, Any?>(
            // int: Parcelable interface
            "describeContents" to icon?.describeContents(),
            // int: Gets the resource used to create this icon.
            "resId" to icon?.getResId(),
            // int: Gets the type of the icon provided.
            "type" to icon?.getType(),            
            "imageData" to getImageDataFromIcon(icon, context, Bitmap.CompressFormat.PNG, 100),
        )
    }

    private fun getDrawableFromResourceId(context: Context, resourceId: Int): Drawable? {
        return ContextCompat.getDrawable(context, resourceId)
    }

    private fun getBitmapFromDrawable(drawable: Drawable?): Bitmap? {
        return (drawable as? BitmapDrawable)?.bitmap
    }

    private fun getBitmapFromIcon(icon: Icon?, context: Context): Bitmap? {
        return if (icon == null) {
            null
        } else {
            val drawable = icon.loadDrawable(context)
            if (drawable is BitmapDrawable) {
                return drawable.getBitmap()
            }
            return null
        }
    }

    private fun convertBitmapToByteArray(bitmap: Bitmap, format: Bitmap.CompressFormat, quality: Int): ByteArray {
        val stream = ByteArrayOutputStream()
        bitmap.compress(format, quality, stream)
        return stream.toByteArray()
    }

    private fun getImageDataFromIcon(icon: Icon?, context: Context, format: Bitmap.CompressFormat, quality: Int): ByteArray? {
        val bitmap = getBitmapFromIcon(icon, context)
        return bitmap?.let { convertBitmapToByteArray(it, format, quality) }
    }

    private fun convertUnixMillisToFormattedDate(unixMillis: Long?, formatPattern: String): String {
        val date = Date(unixMillis ?: 0)
        val format = SimpleDateFormat(formatPattern)
        return format.format(date)
    }

    private fun sendMyNotification(packageName: String, notification: Notification?, notificationContent: String) {
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
        delayBy5minutesIntent.putExtra("notificationContent", notificationContent)
        delayBy5minutesIntent.putExtra("packageName", packageName)
        val delayBy5minutesPendingIntent = PendingIntent.getBroadcast(this, 0, delayBy5minutesIntent, PendingIntent.FLAG_IMMUTABLE)

        val delayBy10minutesIntent = Intent(this, DelayBy10MinutesReciever::class.java)
        delayBy10minutesIntent.putExtra("notificationContent", notificationContent)
        delayBy10minutesIntent.putExtra("packageName", packageName)
        val delayBy10minutesPendingIntent = PendingIntent.getBroadcast(this, 0, delayBy10minutesIntent, PendingIntent.FLAG_IMMUTABLE)

        val delayBy60minutesIntent = Intent(this, DelayBy60MinutesReciever::class.java)
        delayBy60minutesIntent.putExtra("notificationContent", notificationContent)
        delayBy60minutesIntent.putExtra("packageName", packageName)
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
