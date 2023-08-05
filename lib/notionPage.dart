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
          title: Text('Notion Integration'),
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {},
            ),
          ],
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: NotionWidget(),
          ),
        ),
      ),
    );
  }
}