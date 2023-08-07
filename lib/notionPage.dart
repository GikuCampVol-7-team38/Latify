import 'package:flutter/material.dart';
import 'package:latify/notionWidget.dart'; // NotionWidgetへの正しいパスに変更してください

class NotionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.blue,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.1),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notion Integration'),
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {},
            ),
          ],
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: NotionWidget(),
        ),
      ),
    );
  }
}
