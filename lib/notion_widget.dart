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

  int _statusCode = 200;
  bool _isSent = false;
  bool _isLoading = false;
  final TextEditingController _apiKeyController = TextEditingController();
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

  Future<void> _check() async {
    setState((){
      _isSent = true;
      _isLoading = true;
    });

    final status = await checkApiKeyAndDatabaseID(await _getApiKey(), _databaseIdController.text);

    setState((){
      _isLoading = false;
      _statusCode = status;
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
  void dispose() {
    _apiKeyController.dispose();
    _databaseIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding:  EdgeInsets.fromLTRB(0, 16, 0, 0),
          child:
          Text('API key'),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
          child:
          FutureBuilder<String>(
            future: _getApiKey(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                _apiKeyController.text = snapshot.data ?? '';
                return TextField(
                  controller: _apiKeyController,
                  onChanged: (value) {
                    _setApiKey(value);
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Enter your API key',
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
        const Text('Database ID'),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
          child:
          FutureBuilder<String>(
            future: _getDatabaseID(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                _databaseIdController.text = snapshot.data ?? '';
                return TextField(
                  controller: _databaseIdController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Enter your Database ID or URL',
                  ),
                  onChanged: (value) {
                    _parseDatabaseIdFromUrl(); // テキストが変更されるたびにURLをパース
                    _setDatabaseID(_databaseIdController.text);
                  },
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
          child:
          Text('Your API Key and Database ID are encrypted and stored locally.'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _check,
          child: const Text('Check API key and Database ID'),
        ),
        Text(_isSent ? _isLoading ? '' : _statusCode == 200 ? 'API Key and Database ID are valid.' : _statusCode == 401 ? 'API Key is invalid.' : _statusCode == 400 ? 'Database ID is invalid.' : 'Unknown Error.' : ''),
        _isLoading ? const CircularProgressIndicator() : Container(),
      ],
    );
  }
}
