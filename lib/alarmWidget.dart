import 'package:flutter/material.dart';

class AlarmWidget extends StatefulWidget {
  const AlarmWidget({super.key});

  @override
  State<AlarmWidget> createState() => _AlarmWidgetState();
  /*
  Widget build(BuildContext context) {
  return MaterialApp(
  title: 'Scrollable List Example',
  theme: ThemeData(
  primarySwatch: Colors.blue,
  ),
  //home: ScrollableListScreen(),
  );
  }
   */
}

class _AlarmWidgetState extends State<AlarmWidget> {
  List<String> textList = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    'Item 6',
    'Item 7',
    'Item 8',
    'Item 9',
    'Item 10',
    'Item 11',
    'Item 12',
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    'Item 6',
    'Item 7',
    'Item 8',
    'Item 9',
    'Item 10',
    'Item 11',
    'Item 12',
  ];

  @override
  Widget build(BuildContext context) {
  return Scaffold(
  //appBar: AppBar(
  //title: Text('Scrollable List Example'),
  //),
  body: ListView.builder(
  itemCount: textList.length,
  itemBuilder: (context, index) {
  return ListTile(
  title: Text(textList[index]),
  );
  },
  ),
  );
  }
}
