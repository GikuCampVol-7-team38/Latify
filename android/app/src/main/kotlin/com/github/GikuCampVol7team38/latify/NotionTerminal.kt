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

            val jhon ="\"properties\": {\"title\": {\"title\": [{\"text\": {\"content\": \"新しいページのタイトル\"}}]}}, \"children\": [{\"object\": \"block\", \"type\": \"paragraph\", \"paragraph\": {\"text\": [{\"type\": \"text\", \"text\": {\"content\": \"これは新しく追加されたテキストブロックの内容です。\"}}]}}]"
            
            val url = URL("https://api.notion.com/v1/pages")
            return with(url.openConnection() as HttpURLConnection) {
                requestMethod = "POST"
                connectTimeout = connectTimeoutMillis
                readTimeout = readTimeoutMillis

                setRequestProperty("Authorization", "Bearer $apiKey")
                setRequestProperty("Content-Type", "application/json")
                setRequestProperty("Notion-Version", "2021-08-16")

                OutputStreamWriter(outputStream, Charsets.UTF_8).use {
                    println("{\"parent\":{\"database_id\":\"$databaseID\"},$json}")
                    it.write("{\"parent\":{\"database_id\":\"$databaseID\"},$json}")
                    it.flush()
                }

                if (responseCode == HttpURLConnection.HTTP_OK) {
                    val responseContent = inputStream.bufferedReader().use { it.readText() }
                    println("Response: $responseContent")
                } else {
                    val errorResponse = errorStream.bufferedReader().use { it.readText() }
                    println("Error Response: $errorResponse")
                }

                responseCode == HttpURLConnection.HTTP_OK
            }
        }
    }
}
