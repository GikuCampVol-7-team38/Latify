package com.github.GikuCampVol7team38.latify

import android.service.notification.NotificationListenerService
import android.service.notification.StatusBarNotification

import android.util.Log

class MyNotificationListenerService : NotificationListenerService() {
    override fun onNotificationPosted(sbn: StatusBarNotification?) {
        super.onNotificationPosted(sbn)
        // Handle notification when posted
        sbn?.let {
            val notificationText = it.notification.tickerText?.toString() ?: ""
            Log.d("NotificationListener", "Notification posted: $notificationText")
        }
    }

    override fun onNotificationRemoved(sbn: StatusBarNotification?) {
        super.onNotificationRemoved(sbn)
        // Handle notification when posted
    }
}
