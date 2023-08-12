package com.github.GikuCampVol7team38.latify

import android.content.Context
import java.io.File

class  NotionTemplate {

    companion object {
        fun getRecieved(context: Context): String {
            val file = File(context.filesDir, "Recieved")
            val str = EncryptedStorage.readString(file)
            if (str.isEmpty()) {
                return ""
            }
            return str
        }

        fun getLeftButton(context: Context): String {
            val file = File(context.filesDir, "LeftButton")
            val str = EncryptedStorage.readString(file)
            if (str.isEmpty()) {
                return ""
            }
            return str
        }

        fun getMiddleButton(context: Context): String {
            val file = File(context.filesDir, "MiddleButton")
            val str = EncryptedStorage.readString(file)
            if (str.isEmpty()) {
                return ""
            }
            return str
        }

        fun getRightButton(context: Context): String {
            val file = File(context.filesDir, "RightButton")
            val str = EncryptedStorage.readString(file)
            if (str.isEmpty()) {
                return ""
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
