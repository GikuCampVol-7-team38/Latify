import 'dart:convert';
import 'package:http/http.dart' as http;

/// Adds a note to the specified Notion database.
///
/// [notionApiKey] - The Notion API key
/// [databaseID] - The ID of the database to write to
/// [title] - The title of the note to add
///
/// Returns: `true` if successful, `false` otherwise
Future<bool> addNoteToNotionTable(String notionApiKey, String databaseID,String title) async {
  final url = Uri.parse('https://api.notion.com/v1/pages');

  final headers = {
    'Authorization': 'Bearer $notionApiKey',
    'Notion-Version': '2021-08-16',
    'Content-Type': 'application/json',
  };

  final body = jsonEncode({
    'parent': {'database_id': databaseID},
    'properties': {
      'title': {'title': [{'text': {'content': title}}]},
    },
  });

  final response = await http.post(url, headers: headers, body: body);

  return response.statusCode == 200;
}
