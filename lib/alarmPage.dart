import 'package:flutter/material.dart';
import 'package:latify/alarmWidget.dart';

class AlarmPage extends StatelessWidget {
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
          title: Text('Alarm List'),
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
            child: AlarmWidget(),
          ),
        ),
      ),
    );
  }
}
