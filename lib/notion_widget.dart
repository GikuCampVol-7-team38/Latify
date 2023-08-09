import 'dart:convert';
import 'dart:io' show Platform;

import 'package:flutter/src/foundation/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'notion.dart';

class NotionWidget extends StatefulWidget {
  const NotionWidget({super.key});

  @override
  State<NotionWidget> createState() => _NotionWidgetState();
}

class _NotionWidgetState extends State<NotionWidget> {
  static const _notion = MethodChannel('com.github.GeekCampVol7team38.latify/notion');

  bool _isSuccess = false;
  bool _isSent = false;
  bool _isLoading = false;
  String _notionApiKey = '';
  String _title = '';
  final TextEditingController _databaseIdController = TextEditingController();

  static Future<String> _getApiKey() {
    try {
      return _notion.invokeMethod('getApiKey').then((value) {
        if (value is String) {
          return value;
        }
        return '';
      });
    } on PlatformException catch (_) {
      return Future.value('');
    }
  }

  static Future<String> _getDatabaseID() {
    try {
      return _notion.invokeMethod('getDatabaseID' ,{'databaseKey': 'key'}).then((value) {
        if (value is String) {
          return value;
        }
        return '';
      });
    } on PlatformException catch (_) {
      return Future.value('');
    }
  }

  static Future<bool> _setApiKey(String apiKey) {
    try {
      return _notion.invokeMethod('setApiKey' ,{'apiKey': apiKey}).then((value) {
        if (value is bool) {
          return value;
        }
        return false;
      });
    } on PlatformException catch (_) {
      return Future.value(false);
    }
  }

  static Future<bool> _setDatabaseID(String databaseID) {
    try {
      return _notion.invokeMethod('setDatabaseID' ,{'databaseKey': 'key', 'databaseID': databaseID}).then((value) {
        if (value is bool) {
          return value;
        }
        return false;
      });
    } on PlatformException catch (_) {
      return Future.value(false);
    }
  }

  static Future<bool> _send(String title) {
    try {
      return _notion.invokeMethod('send', {
            'databaseKey': 'key',
            'json': jsonEncode({'properties': {'title': {'title': [{'text': {'content': title}}]}}, })
      }).then((value) {
        if (value is bool) {
          return value;
        }
        return false;
      });
    } on PlatformException catch (_) {
      return Future.value(false);
    }
  }

  Future<void> sendToNotion() async {
    setState((){
      _isSent = true;
      _isLoading = true;
    });
    _setApiKey(_notionApiKey);
    _setDatabaseID(_databaseIdController.text);

    if (kIsWeb || !Platform.isAndroid) {
      _isSuccess = await addNoteToNotionTable(_notionApiKey, _databaseIdController.text, _title);
    } else {
      _isSuccess = await _send(_title);
    }
    setState((){
      _isLoading = false;
      _isSuccess = _isSuccess;
    });
  }

  void _parseDatabaseIdFromUrl() {
    final value = _databaseIdController.text;
    final regex = RegExp(r'https://www\.notion\.so/.{32}');
    final match = regex.firstMatch(value);

    if (match != null) {
      final databaseId = value.substring(22, 54);
      _databaseIdController.text = databaseId;
      _databaseIdController.selection = TextSelection.fromPosition(TextPosition(offset: databaseId.length)); // カーソル位置の更新
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Your API key and Database ID are encrypted and stored locally'),
        FutureBuilder<String>(
          future: _getApiKey(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return TextFormField(
                initialValue: snapshot.data,
                onChanged: (value) {
                  _notionApiKey = value;
                },
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Enter your API key',
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
        FutureBuilder<String>(
          future: _getDatabaseID(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              _databaseIdController.text = snapshot.data ?? '';
              return TextFormField(
                controller: _databaseIdController,
                decoration: const InputDecoration(
                  hintText: 'Enter your Database ID or URL',
                ),
                onChanged: (value) {
                  _parseDatabaseIdFromUrl(); // テキストが変更されるたびにURLをパース
                },
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
        TextField(
          onChanged: (value) {
            _title = value;
          },
          decoration: const InputDecoration(
            hintText: 'Enter the title of the note',
          ),
        ),
        Text(_isSent ? _isLoading ? '' : _isSuccess ? 'Success' : 'Failed' : ''),
        _isLoading ? const CircularProgressIndicator() : Container(),
        ElevatedButton(
          onPressed: _isLoading ? null : sendToNotion,
          child: const Text('Send to Notion'),
        ),
      ],
    );
  }
}
