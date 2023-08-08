import 'package:flutter/material.dart';

import 'notion.dart';

class NotionWidget extends StatefulWidget {
  const NotionWidget({super.key});

  @override
  State<NotionWidget> createState() => _NotionWidgetState();
}

class _NotionWidgetState extends State<NotionWidget> {
  bool _success = false;
  bool _isLoading = false;
  String _notionApiKey = '';
  String _databaseID = '';
  String _title = '';
  final TextEditingController _databaseIdController = TextEditingController();


  Future<void> sendToNotion() async {
    setState((){
      _isLoading = true;
    });
    _success = await addNoteToNotionTable(_notionApiKey, _databaseIdController.text, _title);
    setState((){
      _isLoading = false;
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
        TextField(
          onChanged: (value) {
            _notionApiKey = value;
          },
          obscureText: true,
          decoration: const InputDecoration(
            hintText: 'Enter your API key',
          ),
        ),
        TextField(
          controller: _databaseIdController,
          decoration: const InputDecoration(
            hintText: 'Enter your Database Link',
          ),
          onChanged: (value) {
            _parseDatabaseIdFromUrl(); // テキストが変更されるたびにURLをパース
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
        Text(_success ? 'Success!' : 'Failed'),
        _isLoading ? const CircularProgressIndicator() : Container(),
        ElevatedButton(
          onPressed: _isLoading ? null:sendToNotion,
          child: const Text('Send to Notion'),
        ),
      ],
    );
  }
}
