package com.github.GikuCampVol7team38.latify

import android.content.Context
import java.io.File

class NotionData {

    companion object {
        fun load(context: Context): NotionData {
            val file = File(context.filesDir, "NotionData")
            if (file.exists()) {
                val bytes = file.readBytes()
                val map = MyMessagePack.unpack(bytes)
                return NotionData().apply {
                    decrypt(EncryptedData.fromMap(map))
                }               
            } else {
                return NotionData()
            }
        }
    }

    fun save(context: Context) {
        val bytes = MyMessagePack.pack(encrypt().toMap())
        val file = File(context.filesDir, "NotionData")
        file.writeBytes(bytes)
    }

    var ApiKey: String = "";
    val databaseIDMap: MutableMap<String, String> = mutableMapOf<String, String>();

    private fun encrypt(): EncryptedData {
        val dataEncryptor = DataEncryptor()
        val encryptedDatabaseIDMap = mutableMapOf<String, MutableMap<String, ByteArray>>()
        for ((key, value) in databaseIDMap) {
            val map = mutableMapOf<String, ByteArray>()
            dataEncryptor.encryptString(value).let { (encrypted, iv) ->
                map["encryptedDatabaseID"] = encrypted
                map["iv"] = iv
            }
            encryptedDatabaseIDMap[key] = map
        }
        dataEncryptor.encryptString(ApiKey).let { (encrypted, iv) ->
        return EncryptedData(encrypted, iv, encryptedDatabaseIDMap)
        }
    }

    private fun decrypt(encryptedData: EncryptedData) {
        val dataEncryptor = DataEncryptor()
        dataEncryptor.decryptString(encryptedData.encryptedApiKey, encryptedData.iv).let {
            ApiKey = it
        }
        for ((key, value) in encryptedData.encryptedDatabaseIDMap) {
            val encryptedDatabaseID = value["encryptedDatabaseID"]
            val iv = value["iv"]
            if (encryptedDatabaseID == null || iv == null) {
                continue
            }
            dataEncryptor.decryptString(encryptedDatabaseID, iv).let {
                databaseIDMap[key] = it
            }
        }
    }

    private class EncryptedData (
        val encryptedApiKey: ByteArray, 
        val iv: ByteArray, 
        val encryptedDatabaseIDMap: MutableMap<String, MutableMap<String, ByteArray>>
        ) {
        companion object {
            fun fromMap(map: Map<String, Any?>): EncryptedData {
                return EncryptedData(map["encryptedApiKey"] as ByteArray,
                 map["iv"] as ByteArray,
                 map["encryptedDatabaseIDMap"] as MutableMap<String, MutableMap<String, ByteArray>>
                )
            }
        }

        fun toMap(): Map<String, Any?> {
            return mapOf(
                    "encryptedApiKey" to encryptedApiKey,
                    "iv" to iv,
                    "encryptedDatabaseIDMap" to encryptedDatabaseIDMap
            )
        }
    }
}
