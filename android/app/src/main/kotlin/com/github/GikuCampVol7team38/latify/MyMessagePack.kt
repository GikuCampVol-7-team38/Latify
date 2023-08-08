package com.github.GikuCampVol7team38.latify

import org.msgpack.core.MessageBufferPacker
import org.msgpack.core.MessagePack
import org.msgpack.core.MessageUnpacker

class MyMessagePack{
    companion object {
        fun pack(map: Map<String, Any?>): ByteArray {
            val packer = MessagePack.newDefaultBufferPacker()
            packNestedMap(packer, map)
            val result = packer.toByteArray()
            packer.close()
            return result
        }

        fun unpack(bytes: ByteArray): Map<String, Any?> {
            val unpacker = MessagePack.newDefaultUnpacker(bytes)
            val result = unpackNestedMap(unpacker)
            unpacker.close()
            return result
        }

        private fun packNestedMap(packer: MessageBufferPacker, map: Map<String, Any?>) {
            packer.packMapHeader(map.size)
            for ((key, value) in map) {
                packer.packString(key)
                packValue(packer, value)
            }
        }

        private fun packValue(packer: MessageBufferPacker, value: Any?) {
            when (value) {
                null -> packer.packNil()
                is Boolean -> packer.packBoolean(value)
                is Byte -> packer.packByte(value)
                is Short -> packer.packShort(value)
                is Int -> packer.packInt(value)
                is Long -> packer.packLong(value)
                is Float -> packer.packFloat(value)
                is Double -> packer.packDouble(value)
                is String -> packer.packString(value)
                is ByteArray -> packer.packBinaryHeader(value.size).writePayload(value)
                is Map<*, *> -> packNestedMap(packer, value as Map<String, Any?>)
                is List<*> -> {
                    packer.packArrayHeader(value.size)
                    for (item in value) {
                        packValue(packer, item)
                    }
                }
                // else -> throw Exception("Unsupported type: ${value::class.java}")
            }
        }

        private fun unpackNestedMap(unpacker: MessageUnpacker): Map<String, Any?> {
            val mapSize = unpacker.unpackMapHeader()
            val resultMap = hashMapOf<String, Any?>()
            for (i in 0 until mapSize) {
                val key = unpacker.unpackString()
                val value = unpackValue(unpacker)
                resultMap[key] = value
            }
            return resultMap
        }

        private fun unpackValue(unpacker: MessageUnpacker): Any? {
            return when (unpacker.getNextFormat()) {
                org.msgpack.core.MessageFormat.BOOLEAN -> unpacker.unpackBoolean()
                org.msgpack.core.MessageFormat.STR8,
                org.msgpack.core.MessageFormat.STR16,
                org.msgpack.core.MessageFormat.FIXSTR -> unpacker.unpackString()
                org.msgpack.core.MessageFormat.INT32 -> unpacker.unpackInt()
                org.msgpack.core.MessageFormat.INT64 -> unpacker.unpackLong()
                org.msgpack.core.MessageFormat.FLOAT32 -> unpacker.unpackFloat()
                org.msgpack.core.MessageFormat.FLOAT64 -> unpacker.unpackDouble()
                org.msgpack.core.MessageFormat.POSFIXINT,
                org.msgpack.core.MessageFormat.NEGFIXINT -> unpacker.unpackInt()
                org.msgpack.core.MessageFormat.UINT16,
                org.msgpack.core.MessageFormat.UINT32,
                org.msgpack.core.MessageFormat.UINT64 -> unpacker.unpackLong()
                org.msgpack.core.MessageFormat.MAP16,
                org.msgpack.core.MessageFormat.MAP32,
                org.msgpack.core.MessageFormat.FIXMAP -> unpackNestedMap(unpacker)
                org.msgpack.core.MessageFormat.ARRAY16,
                org.msgpack.core.MessageFormat.ARRAY32,
                org.msgpack.core.MessageFormat.FIXARRAY -> {
                    val arraySize = unpacker.unpackArrayHeader()
                    val resultArray = arrayListOf<Any?>()
                    for (i in 0 until arraySize) {
                        resultArray.add(unpackValue(unpacker))
                    }
                    resultArray
                }
                org.msgpack.core.MessageFormat.BIN8,
                org.msgpack.core.MessageFormat.BIN16,
                org.msgpack.core.MessageFormat.BIN32 -> unpacker.readPayload(unpacker.unpackBinaryHeader())
                org.msgpack.core.MessageFormat.NIL -> {
                    unpacker.unpackNil()
                    null
                }
                else -> unpacker.skipValue()
            }
        }
    }
}
