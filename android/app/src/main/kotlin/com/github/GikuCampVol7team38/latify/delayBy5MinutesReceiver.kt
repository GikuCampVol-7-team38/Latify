package com.github.GikuCampVol7team38.latify

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import java.time.LocalDateTime

class DelayBy5MinutesReciever : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        val content = "Pressed: Delay by 5 minutes button\\nPressed Date: ${LocalDateTime.now()}\\n${intent.getStringExtra("notificationContent")}"
        NotionTerminal.send(
                NotionData.load(context),
                "\"properties\":{\"title\":{\"title\":[{\"text\":{\"content\":\"${intent.getStringExtra("packageName")}\"}}]}},\"children\":[{\"object\":\"block\",\"type\":\"paragraph\",\"paragraph\":{\"text\":[{\"type\":\"text\",\"text\":{\"content\":\"$content\"}}]}}]",
                "key",
                5000,
                15000,
                { _ -> {}}
            )
    }
}