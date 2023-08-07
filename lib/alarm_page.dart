import 'package:flutter/material.dart';

import 'alarm_widget.dart';

class AlarmPage extends StatelessWidget {
  const AlarmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.cyan,
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
          title: const Text('Alarm List'),
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
          child: AlarmWidget(),
        ),
      ),
    );
  }
}