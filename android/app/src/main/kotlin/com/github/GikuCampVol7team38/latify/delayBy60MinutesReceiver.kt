package com.github.GikuCampVol7team38.latify

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import java.time.LocalDateTime

class DelayBy60MinutesReciever : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        val map = hashMapOf<String, String>(
            "buttonName" to "DelayByAnHour",
            "pressDate" to LocalDateTime.now().toString(),
        )
        NotionTerminal.send(
            NotionData.load(context),
            NotionTemplate.applyDynamicTemplate(intent.getStringExtra("msg") ?: "", map),
            "key",
            5000,
            15000,
            { _ -> {}}
        )
    }
}