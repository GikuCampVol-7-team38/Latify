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
  Map<String, String> alarmData = {};

  //アラームと通知に関する情報を格納
  //var alarmData = alarmList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
      // title: Text('Scrollable List Example'),
      // ),
      body: ListView.separated(
        itemCount: alarmList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(alarmList[index]),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // 編集ボタンの処理
                    _editItem(index);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // 削除ボタンの処理
                    _deleteItem(index);
                  },
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
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
      alarmList.removeAt(index);
    });
  }
}
