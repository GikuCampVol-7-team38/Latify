import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:msgpack_dart/msgpack_dart.dart';
import 'package:intl/intl.dart';

import 'alarmList.dart';
import 'application_state.dart';
import 'notification_data.dart';
import 'notionPage.dart';
import 'permanentNotification.dart';
import 'queryNewNotification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  // Androidのデフォルトアイコンを使用
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  final PermanentNotification notification =
  PermanentNotification(flutterLocalNotificationsPlugin);

  await notification.showNotification();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Latify',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Alarm List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final MethodChannel _lifecycleChannel = const MethodChannel('com.github.GeekCampVol7team38.latify/lifecycle');
  final MethodChannel _notificationAccessChannel = const MethodChannel('com.github.GeekCampVol7team38.latify/notification_access');
  final MethodChannel _storageChannel = const MethodChannel('com.github.GeekCampVol7team38.latify/storage');

  Future<void> _checkPermission() async {
    try {
      if (Platform.isAndroid) {
        final isEnabled = await _notificationAccessChannel.invokeMethod('isNotificationAccessEnabled');
        if (!isEnabled) {
          await _notificationAccessChannel.invokeMethod('requestNotificationAccess');
        }

        await FlutterLocalNotificationsPlugin().resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()!.requestPermission();
      }
    } on PlatformException catch (_) {
    }
  }

  Future<void> _reloadNotification() async {
    if (!Platform.isAndroid) {
      return;
    }

    final notifications = await NewNotification.getList();

    if (notifications == null) {
      return;
    }

    for (final n in notifications) {
      final sbn = await NewNotification.peek(n);

      if (sbn == null) {
        continue;
      }

      final result = await _storageChannel.invokeMethod('read', {'fileName': 'AppState'});
      var applicationState = ApplicationState();

      if (result != null) {
        applicationState = ApplicationState.fromDynamic(deserialize(result)) ?? applicationState;
      }

      final notificationData = NotificationData(sbn);
      applicationState.notificationList.add(notificationData);

      await _storageChannel.invokeMethod('write', {'fileName': 'AppState', 'bytes': serialize(applicationState.toMap())});

      await NewNotification.delete(n);
    }
    final result = await _storageChannel.invokeMethod('read', {'fileName': 'AppState'});

    if (result == null) {
      return;
    }

    setState((){
      _applicationState = ApplicationState.fromDynamic(deserialize(result ?? Uint8List(0))) ?? ApplicationState();
    });
  }

  @override
  void initState() {
    super.initState();
    _checkPermission();
    _reloadNotification();

    _lifecycleChannel.setMethodCallHandler((MethodCall methodCall) {
      if (methodCall.method == 'activityResumed') {
        return _reloadNotification();
      }
      return Future.value();
    });
  }

  void _navigateToNotionPage(){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NotionPage())
    );
  }

  AlarmList alarmList = AlarmList();
  bool isEditing = false;
  TextEditingController editingController = TextEditingController();
  DateTime selectedDateTime = DateTime.now();
  int editingIndex = -1;

  ApplicationState _applicationState = ApplicationState();

  @override
  void dispose() {
    editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: _applicationState.notificationList.length,
                itemBuilder: (context, index) {
                  final isCurrentlyEditing = isEditing && editingIndex == index;

                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('アラーム日時'),
                          isCurrentlyEditing
                              ? TextFormField(
                            controller: editingController,
                            onEditingComplete: () {
                              _saveEdit(index);
                            },
                          )
                              : Text(
                            DateFormat('yyyy-MM-dd HH:mm').format(DateTime.fromMillisecondsSinceEpoch(_applicationState.notificationList[index].statusBarNotification.getPostTime ?? 0)),
                          ),
                          const Text(''),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_applicationState.notificationList[index].statusBarNotification.getPackageName ?? '',
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,),
                          Text(_applicationState.notificationList[index].statusBarNotification.getNotification?.tickerText?.value ?? '',
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              _startEditing(index);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              _deleteItem(index);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.calendar_today),
                            onPressed: () {
                              _selectDateTime(index);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _navigateToNotionPage,
              child: const Text('Go to Notion Page'),
            ),
          ],
        ),
      ),
    );
  }

  void _startEditing(int index) {
    setState(() {
      isEditing = true;
      editingIndex = index;
      editingController.text = alarmList.alarmTimeList[index];
    });
  }

  Future<void> _selectDateTime(int index) async {
    final DateTime? pickedDateTime = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (!mounted) return;

    if (pickedDateTime != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            pickedDateTime.year,
            pickedDateTime.month,
            pickedDateTime.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          alarmList.alarmTimeList[index] =
              DateFormat('yyyy-MM-dd HH:mm').format(selectedDateTime);
        });
      }
    }
  }

  void _saveEdit(int index) {
    setState(() {
      isEditing = false;
      editingIndex = -1;
      alarmList.alarmTimeList[index] = editingController.text;
      editingController.text = '';
    });
  }

  void _deleteItem(int index) {
    setState(() {
      // 削除ボタンが押されたアイテムをリストから削除
      alarmList.alarmTextList.removeAt(index);
    });
  }
}
