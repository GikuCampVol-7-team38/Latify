import 'package:flutter/material.dart';
import 'package:latify/alarmList.dart';

class AlarmWidget extends StatefulWidget {
  const AlarmWidget({Key? key}) : super(key: key);

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
  AlarmList alarmList = AlarmList();
  Map<String, String> alarmData = {};

  //アラームと通知に関する情報を格納
  //var alarmData = alarmList;

  @override
  Widget build(BuildContext context) {
    AlarmList alarmList = AlarmList();
    return Scaffold(
      appBar: AppBar(
       title: const Text('Scrollable List Example'),
       ),
      body: ListView.separated(
        itemCount: alarmList.alarmTextList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              alarmList.alarmTextList[index]
            ),
            subtitle: Text(
                alarmList.subAlarmTextList[index]
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    _editItem(index);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    _deleteItem(index);
                  },
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            color: Colors.red,
            thickness: 3,
          );
        },
      ),
    );
  }

  void _editItem(int index) {
    // 編集ボタンが押されたアイテムを処理
    // 例えば、ダイアログを表示して新しい値を入力させるなどの処理を行う
  }

  void _deleteItem(int index) {
    setState(() {
      // 削除ボタンが押されたアイテムをリストから削除
      alarmList.alarmTextList.removeAt(index);
    });
  }
}
