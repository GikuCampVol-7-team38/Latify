import 'package:flutter/material.dart';
import 'package:latify/notion.dart';

class NotionWidget extends StatefulWidget {
  const NotionWidget({super.key});

  @override
  State<NotionWidget> createState() => _NotionWidgetState();
}

class _NotionWidgetState extends State<NotionWidget> {
  bool success = false;
  bool isLoading = false;
  String notionApiKey = '';
  String databaseID = '';
  String title = '';
  final TextEditingController databaseIdController = TextEditingController();


  Future<void> sendToNotion() async {
    setState((){
      isLoading = true;
    });
    success = await addNoteToNotionTable(notionApiKey, databaseIdController.text, title);
    setState((){
      isLoading = false;
    });
  }
  void _parseDatabaseIdFromUrl() {
    final value = databaseIdController.text;
    final regex = RegExp(r'https://www\.notion\.so/.{32}');
    final match = regex.firstMatch(value);

    if (match != null) {
      final databaseId = value.substring(22, 54);
      databaseIdController.text = databaseId;
      databaseIdController.selection = TextSelection.fromPosition(TextPosition(offset: databaseId.length)); // カーソル位置の更新
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          onChanged: (value) {
            notionApiKey = value;
          },
          obscureText: true,
          decoration: const InputDecoration(
            hintText: 'Enter your API key',
          ),
        ),
        TextField(
          controller: databaseIdController,
          decoration: const InputDecoration(
            hintText: 'Enter your Database Link',
          ),
          onChanged: (value) {
            _parseDatabaseIdFromUrl(); // テキストが変更されるたびにURLをパース
          },
        ),
        TextField(
          onChanged: (value) {
            title = value;
          },
          decoration: const InputDecoration(
            hintText: 'Enter the title of the note',
          ),
        ),
        Text(success ? 'Success!' : 'Failed'),
        isLoading ? const CircularProgressIndicator() : Container(),
        ElevatedButton(
          onPressed: isLoading ? null:sendToNotion,
          child: const Text('Send to Notion'),
        ),
      ],
    );
  }
}
