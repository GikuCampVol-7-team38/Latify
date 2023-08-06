package com.github.GikuCampVol7team38.latify

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent

class DelayBy60MinutesReciever : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        println("NotificationReceiver.onReceive")
    }
}