package com.github.GikuCampVol7team38.latify

import java.io.File

class EncryptedStorage {

    companion object{
        fun readBytes(file: File): ByteArray {
            val encryptedBytes = file.readBytes()
            if (encryptedBytes.size < 16) {
                return byteArrayOf()
            }
            val iv = encryptedBytes.sliceArray(0..15)
            val encryptedData = encryptedBytes.sliceArray(16 until encryptedBytes.size)
            return DataEncryptor().decryptBytes(encryptedData, iv)
        }

        fun writeBytes(file: File, bytes: ByteArray) {
            val (encryptedData, iv) = DataEncryptor().encryptBytes(bytes)
            val encryptedBytes = iv + encryptedData
            file.writeBytes(encryptedBytes)
        }
    }
}
