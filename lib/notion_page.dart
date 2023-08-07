import 'package:flutter/material.dart';

import 'notion_widget.dart';

class NotionPage extends StatelessWidget {
  const NotionPage({super.key});

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
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: NotionWidget(),
        ),
      ),
    );
  }
}
