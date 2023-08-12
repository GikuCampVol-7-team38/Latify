package com.github.GikuCampVol7team38.latify

import android.content.Context
import java.io.File

class  NotionTemplate {

    companion object {
        fun applyDynamicTemplate(template: String, values: Map<String, String>): String {
            var result = template
            for ((key, value) in values) {
                result = result.replace("\${$key}", value)
            }
            println(result)
            return result
        }

        fun getRecieved(context: Context): String {
            val default =
                "\"properties\":{\"title\":{\"title\":[{\"text\":{\"content\":\"\${notificationContent}\"}}]}," +
                        "\"タグ\":{\"type\":\"multi_select\",\"multi_select\":[{\"name\":\"\${appName}\"}]}}," +
                        "\"children\":[{\"object\":\"block\",\"type\":\"paragraph\",\"paragraph\":" +
                        "{\"text\":[{\"type\":\"text\",\"text\":{\"content\":\"Notification Date: \${postDate}\\n\"}}]}}]"

            val file = File(context.filesDir, "Recieved")
            if (!file.exists()) {
                return default
            }
            val str = EncryptedStorage.readString(file)
            if (str.isEmpty()) {
                return default
            }
            return str
        }

        private val defaultButtonPressedTemplate = "\"properties\":{\"title\":{\"title\":[{\"text\":{\"content\":\"\${buttonName}\"}}]}," +
                "\"タグ\":{\"type\":\"multi_select\",\"multi_select\":[{\"name\":\"\${appName}\"}]}}," +
                "\"children\":[{\"object\":\"block\",\"type\":\"paragraph\",\"paragraph\":" +
                "{\"text\":[{\"type\":\"text\",\"text\":{\"content\":\"Notification Date: \${postDate}\\n\\n\${notificationContent}\\n\"}}]}}]"

        fun getLeftButton(context: Context): String {
            val file = File(context.filesDir, "LeftButton")
            if (!file.exists()) {
                return defaultButtonPressedTemplate
            }
            val str = EncryptedStorage.readString(file)
            if (str.isEmpty()) {
                return defaultButtonPressedTemplate
            }
            return str
        }

        fun getMiddleButton(context: Context): String {
            val file = File(context.filesDir, "MiddleButton")
            if (!file.exists()) {
                return defaultButtonPressedTemplate
            }
            val str = EncryptedStorage.readString(file)
            if (str.isEmpty()) {
                return defaultButtonPressedTemplate
            }
            return str
        }

        fun getRightButton(context: Context): String {
            val file = File(context.filesDir, "RightButton")
            if (!file.exists()) {
                return defaultButtonPressedTemplate
            }
            val str = EncryptedStorage.readString(file)
            if (str.isEmpty()) {
                return defaultButtonPressedTemplate
            }
            return str
        }

        fun setRecieved(context: Context, str: String) {
            val file = File(context.filesDir, "Recieved")
            EncryptedStorage.writeString(file, str)
        }

        fun setLeftButton(context: Context, str: String) {
            val file = File(context.filesDir, "LeftButton")
            EncryptedStorage.writeString(file, str)
        }

        fun setMiddleButton(context: Context, str: String) {
            val file = File(context.filesDir, "MiddleButton")
            EncryptedStorage.writeString(file, str)
        }

        fun setRightButton(context: Context, str: String) {
            val file = File(context.filesDir, "RightButton")
            EncryptedStorage.writeString(file, str)
        }
    }
}
