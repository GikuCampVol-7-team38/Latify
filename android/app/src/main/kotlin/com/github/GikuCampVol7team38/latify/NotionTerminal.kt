package com.github.GikuCampVol7team38.latify

import java.io.OutputStreamWriter
import java.net.HttpURLConnection
import java.net.URL
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

class NotionTerminal{

    companion object {
        fun send(
            notionData: NotionData,
            json: String,
            databaseKey: String,
            connectTimeoutMillis: Int = 5000,
            readTimeoutMillis: Int = 15000,
            onResult: (Boolean) -> Unit
        ) {
            CoroutineScope(Dispatchers.Main).launch {
                val result = withContext(Dispatchers.IO) {
                    sendInternal(notionData, json, databaseKey, connectTimeoutMillis, readTimeoutMillis)
                }
                onResult(result)
            }
        }

        private fun sendInternal(
            notionData: NotionData,
            json: String,
            databaseKey: String,
            connectTimeoutMillis: Int,
            readTimeoutMillis: Int
        ): Boolean {
            val apiKey = notionData.ApiKey
            val databaseID = notionData.databaseIDMap[databaseKey]

            val url = URL("https://api.notion.com/v1/pages")
            return with(url.openConnection() as HttpURLConnection) {
                requestMethod = "POST"
                connectTimeout = connectTimeoutMillis
                readTimeout = readTimeoutMillis

                setRequestProperty("Authorization", "Bearer $apiKey")
                setRequestProperty("Content-Type", "application/json")
                setRequestProperty("Notion-Version", "2021-08-16")

                OutputStreamWriter(outputStream, Charsets.UTF_8).use {
                    it.write("{\"parent\":{\"database_id\":\"$databaseID\"},\"properties\":$json}")
                    it.flush()
                }

                responseCode == HttpURLConnection.HTTP_OK
            }
        }
    }
}
