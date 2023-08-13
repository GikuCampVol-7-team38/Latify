import 'package:flutter/material.dart';

import 'notion_widget.dart';
import 'notion_template_setting_widget.dart';

class NotionPage extends StatelessWidget {
  const NotionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
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
          title: const Text('Notion Setting'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: const Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: [
                NotionWidget(),
                NotionTemplateSettingWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
