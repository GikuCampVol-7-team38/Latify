import 'package:flutter/material.dart';
import 'package:latify/notion.dart';

class NotionWidget extends StatefulWidget {
  const NotionWidget({super.key});

  @override
  State<NotionWidget> createState() => _NotionWidgetState();
}

class _NotionWidgetState extends State<NotionWidget> {
  bool success = false;
  String notionApiKey = '';
  String databaseID = '';
  String title = '';

  Future<void> sendToNotion() async {
    success = await addNoteToNotionTable(notionApiKey, databaseID, title);
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
          onChanged: (value) {
            databaseID = value;
          },
          decoration: const InputDecoration(
            hintText: 'Enter your Database ID',
          ),
        ),
        TextField(
          onChanged: (value) {
            title = value;
          },
          decoration: const InputDecoration(
            hintText: 'Enter the title of the note',
          ),
        ),
        Text(success ? 'Success!' : ''),
        ElevatedButton(
          onPressed: sendToNotion,
          child: const Text('Send to Notion'),
        ),
      ],
    );
  }
}
