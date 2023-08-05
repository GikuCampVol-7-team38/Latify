import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'permanentNotification.dart';

import 'package:latify/marshallingData.dart' as marshallingData;

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

  const notificationListener = MethodChannel('com.github.GeekCampVol7team38.latify/notificationListener');

  notificationListener.setMethodCallHandler((MethodCall methodCall) async {
    if (methodCall.method == 'posted') {
      Map<String, dynamic> data = methodCall.arguments;
      marshallingData.Notification notification = marshallingData.Notification();
      notification.audioStreamType = data['notification.audioStreamType'];
      notification.category = data['notification.category'];
      notification.color = data['notification.color'];
      notification.defaults = data['notification.defaults'];
      notification.flags= data['notification.flags'];
      notification.icon = data['notification.icon'];
      notification.iconLevel = data['notification.iconLevel'];
      notification.ledARGB = data['notification.ledARGB'];
      notification.ledOffMS = data['notification.ledOffMS'];
      notification.ledOnMS = data['notification.ledOnMS'];
      notification.number = data['notification.number'];
      notification.priority = data['notification.priority'];
      notification.vibrate = data['notification.vibrate'];
      notification.visibility = data['notification.visibility'];
      notification.when = data['notification.when'];
      notification.describeContents = data['notification.describeContents'];
      notification.getAllowSystemGeneratedContextualActions = data['notification.getAllowSystemGeneratedContextualActions'];
      notification.getBadgeIconType = data['notification.getBadgeIconType'];
      notification.getChannelId = data['notification.getChannelId'];
      notification.getGroup = data['notification.getGroup'];
      notification.getGroupAlertBehavior = data['notification.getGroupAlertBehavior'];
      notification.getShortcutId = data['notification.getShortcutId'];
      notification.getSortKey = data['notification.getSortKey'];
      notification.getTimeoutAfter = data['notification.getTimeoutAfter'];
      notification.hasImage = data['notification.hasImage'];
      notification.notificationToString = data['notification.notificationToString'];

      marshallingData.UserHandle userHandle = marshallingData.UserHandle();
      userHandle.describeContents = data['userHandle.describeContents'];
      userHandle.userHandleHashCode = data['userHandle.hashCode'];
      userHandle.userHandleToString = data['userHandle.toString'];

      marshallingData.StatusBarNotification statusBarNotification = marshallingData.StatusBarNotification();
      statusBarNotification.describeContents = data['describeContents'];
      statusBarNotification.getGroupKey = data['getGroupKey'];
      statusBarNotification.getId = data['getId'];
      statusBarNotification.getKey = data['getKey'];
      statusBarNotification.getNotification = notification;
      statusBarNotification.getOpPkg = data['getOpPkg'];
      statusBarNotification.getOverrideGroupKey = data['getOverrideGroupKey'];
      statusBarNotification.getPackageName = data['getPackageName'];
      statusBarNotification.getPostTime = data['getPostTime'];
      statusBarNotification.getTag = data['getTag'];
      statusBarNotification.getUid = data['getUid'];
      statusBarNotification.getUserId = data['getUserId'];
      statusBarNotification.isAppGroup = data['isAppGroup'];
      statusBarNotification.isClearable = data['isClearable'];
      statusBarNotification.isGroup = data['isGroup'];
      statusBarNotification.isOngoing = data['isOngoing'];
      statusBarNotification.statusBarNotificationToString = data['toString'];
    }
  });
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;
  final MethodChannel _notificationAccessChannel = const MethodChannel('com.github.GeekCampVol7team38.latify/notification_access');

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

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
