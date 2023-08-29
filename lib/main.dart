import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:msgpack_dart/msgpack_dart.dart';

import 'application_state.dart';
import 'marshalling_data.dart' as marshalling_data;
import 'notification_data.dart';
import 'notion_page.dart';
import 'new_notification.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const _title = 'Latify';

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0x0032de84)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: _title),
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
  static final _dateFormat = DateFormat('yyyy-MM-dd HH:mm');
  static final transparentImage = Uint8List.fromList(<int>[
    0x89,0x50,0x4e,0x47,0x0d,0x0a,0x1a,0x0a,0x00,0x00,0x00,0x0d,0x49,0x48,0x44,0x52,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x04,0x08,0x06,0x00,0x00,0x00,0x4f,0xd8,0x55,0x3a,0x00,0x00,0x00,0x0b,0x49,0x44,0x41,0x54,0x78,0x9c,0x63,0x60,0xc0,0x04,0x00,0x00,0x14,0x00,0x01,0x7d,0xfe,0x1e,0xee,0x00,0x00,0x00,0x00,0x49,0x45,0x4e,0x44,0xae,0x42,0x60,0x82
  ]);

  final MethodChannel _lifecycleChannel = const MethodChannel('com.github.GeekCampVol7team38.latify/lifecycle');
  final MethodChannel _notificationAccessChannel = const MethodChannel('com.github.GeekCampVol7team38.latify/notification_access');
  final MethodChannel _storageChannel = const MethodChannel('com.github.GeekCampVol7team38.latify/storage');

  Future<ApplicationState> _loadAppState() async {
    try {
      final result = await _storageChannel.invokeMethod('read', {'fileName': 'AppState'});
      if (result != null) {
        final appState = ApplicationState.fromDynamic(deserialize(result));
        if (appState != null) {
          return appState;
        }
      }
    } on PlatformException catch (_) {
    }
    return ApplicationState();
  }

  Future<dynamic> _saveAppState(ApplicationState appState) {
    try {
      return _storageChannel.invokeMethod('write', {'fileName': 'AppState', 'bytes': serialize(appState.toMap())});
    } on PlatformException catch (_) {
    }
    return Future.value();
  }

  Future<void> _checkPermission() async {
    try {
      if (!kIsWeb && Platform.isAndroid) {
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
    if (kIsWeb || !Platform.isAndroid) {
      _applicationState.notificationList = [
        NotificationData(
          marshalling_data.StatusBarNotification()
            ..getPackageName = 'Notion'
            ..getPostTime = _dateFormat.parse('2023-08-05 14:00').millisecondsSinceEpoch
            ..getNotification = (marshalling_data.Notification()
              ..tickerText= marshalling_data.CharSequence('卒業研究の中間発表')
            ),
          ),
          NotificationData(
          marshalling_data.StatusBarNotification()
            ..getPackageName = 'Slack'
            ..getPostTime = _dateFormat.parse('2023-08-05 15:00').millisecondsSinceEpoch
            ..getNotification = (marshalling_data.Notification()
              ..tickerText= marshalling_data.CharSequence('8月vol.7ハッカソン技育CAMP')
            ),
          ),
          NotificationData(
          marshalling_data.StatusBarNotification()
            ..getPackageName = 'Line'
            ..getPostTime = _dateFormat.parse('2023-08-05 16:00').millisecondsSinceEpoch
            ..getNotification = (marshalling_data.Notification()
              ..tickerText= marshalling_data.CharSequence('家族')
            ),
          ),
          NotificationData(
          marshalling_data.StatusBarNotification()
            ..getPackageName = 'X'
            ..getPostTime = _dateFormat.parse('2023-08-05 17:00').millisecondsSinceEpoch
            ..getNotification = (marshalling_data.Notification()
              ..tickerText= marshalling_data.CharSequence('Latify')
            ),
          ),
          NotificationData(
          marshalling_data.StatusBarNotification()
            ..getPackageName = 'Discord'
            ..getPostTime = _dateFormat.parse('2023-08-06 18:00').millisecondsSinceEpoch
            ..getNotification = (marshalling_data.Notification()
              ..tickerText= marshalling_data.CharSequence('MSK2')
            ),
          ),
          NotificationData(
          marshalling_data.StatusBarNotification()
            ..getPackageName = 'Teams'
            ..getPostTime = _dateFormat.parse('2023-08-07 19:00').millisecondsSinceEpoch
            ..getNotification = (marshalling_data.Notification()
              ..tickerText= marshalling_data.CharSequence('学校')
            ),
          ),
          NotificationData(
          marshalling_data.StatusBarNotification()
            ..getPackageName = 'GitHub'
            ..getPostTime = _dateFormat.parse('2023-08-07 20:00').millisecondsSinceEpoch
            ..getNotification = (marshalling_data.Notification()
              ..tickerText= marshalling_data.CharSequence('Latify')
            ),
          ),
      ];
      return;
    }
    final applicationState = await _loadAppState();

    final notifications = await NewNotification.getList();

    if (notifications == null) {
      return;
    }

    for (final n in notifications) {
      final notificationData = await NewNotification.peek(n);

      if (notificationData == null) {
        continue;
      }

      applicationState.notificationList.add(notificationData);

      await _saveAppState(applicationState);

      await NewNotification.delete(n);
    }

    setState((){
      _applicationState = applicationState;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkPermission();
    _reloadNotification();

    try{
      _lifecycleChannel.setMethodCallHandler((MethodCall methodCall) {
        if (methodCall.method == 'activityResumed') {
          return _reloadNotification();
        }
        return Future.value();
      });
    } on PlatformException catch (_) {
    }
  }

  void _navigateToNotionPage(){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NotionPage())
    );
  }

  bool _isEditing = false;
  final TextEditingController _editingController = TextEditingController();
  int _editingIndex = -1;

  ApplicationState _applicationState = ApplicationState();

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _navigateToNotionPage,
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: _applicationState.notificationList.length,
                itemBuilder: (context, index) {
                  final isCurrentlyEditing = _isEditing && _editingIndex == index;
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      leading: Image.memory(_applicationState.notificationList[index].statusBarNotification.getNotification?.getSmallIcon?.imageData ?? transparentImage),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('通知日時'),
                          isCurrentlyEditing
                              ? TextFormField(
                            controller: _editingController,
                            onEditingComplete: () {
                              _saveEdit(index);
                            },
                          )
                              : Text(
                            _dateFormat.format(DateTime.fromMillisecondsSinceEpoch(_applicationState.notificationList[index].statusBarNotification.getPostTime ?? 0)),
                          ),
                          const Text(''),
                        ],
                      ),
                      subtitle: FutureBuilder<String>(
                        future: _applicationState.notificationList[index].getAppLabel(),
                        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(snapshot.data ?? '',
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  _applicationState.notificationList[index].statusBarNotification.getNotification?.tickerText?.value ?? '',
                                ),
                              ],
                            );
                          }
                        },
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
          ],
        ),
      ),
    );
  }

  void _startEditing(int index) {
    setState(() {
      _isEditing = true;
      _editingIndex = index;
      _editingController.text = _dateFormat.format(DateTime.fromMillisecondsSinceEpoch(_applicationState.notificationList[index].statusBarNotification.getPostTime ?? 0));
    });
  }

  Future<void> _selectDateTime(int index) async {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(_applicationState.notificationList[index].statusBarNotification.getPostTime ?? 0);
    final DateTime? pickedDateTime = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDateTime == null || !mounted) {
      return;
    }

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(dateTime),
    );

    if (pickedTime == null) {
      return;
    }

    _applicationState.notificationList[index].statusBarNotification.getPostTime = DateTime(
      pickedDateTime.year,
      pickedDateTime.month,
      pickedDateTime.day,
      pickedTime.hour,
      pickedTime.minute,
    ).millisecondsSinceEpoch;
    await _saveAppState(_applicationState);

    setState(() {
      _applicationState = _applicationState;
    });
  }

  void _saveEdit(int index) async {
    final dateTime = _dateFormat.parse(_editingController.text);
    _applicationState.notificationList[index].statusBarNotification.getPostTime = dateTime.millisecondsSinceEpoch;
    await _saveAppState(_applicationState);

    setState(() {
      _isEditing = false;
      _editingIndex = -1;
      _editingController.text = '';
      _applicationState = _applicationState;
    });
  }

  void _deleteItem(int index) async {
    _applicationState.notificationList.removeAt(index);
    await _saveAppState(_applicationState);
    setState(() {
      _applicationState = _applicationState;
    });
  }
}
