import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

Future<void> _configureLocalTimeZone() async {
  tz.initializeTimeZones();
  var turkey = tz.getLocation('Europe/Istanbul');
  tz.setLocalLocation(turkey);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _configureLocalTimeZone();
}

const updateNowTask = "updateNowTask";
const simplePeriodicOneHourTask = "simplePeriodicOneHourTask";
const updatePeriodic24HourTask = "updatePeriodic24HourTask";

void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) async {
    switch (task) {
      case updateNowTask:
        showNotification();
        print("$updateNowTask was executed. inputData = $inputData");
        break;
      case simplePeriodicOneHourTask:
        showNotification();
        print("$simplePeriodicOneHourTask was executed");
        break;
      case updatePeriodic24HourTask:
        showNotification();
        print("$updatePeriodic24HourTask was executed");
        break;
      case Workmanager.iOSBackgroundTask:
        print("The iOS background fetch was triggered");
        Directory tempDir = await getTemporaryDirectory();
        String tempPath = tempDir.path;
        print(
            "You can access other plugins in the background, for example Directory.getTemporaryDirectory(): $tempPath");
        break;
    }

    return Future.value(true);
  });
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

class BackgroundTask extends StatefulWidget {

  @override
  _BackgroundTaskState createState() => _BackgroundTaskState();
}

enum _Platform { android, ios }

class PlatformEnabledButton extends RaisedButton {
  final _Platform platform;

  PlatformEnabledButton({
    this.platform,
    @required Widget child,
    @required VoidCallback onPressed,
  })  : assert(child != null, onPressed != null),
        super(
          child: child,
          onPressed: (Platform.isAndroid && platform == _Platform.android ||
              Platform.isIOS && platform == _Platform.ios)
              ? onPressed
              : null);
}

showNotification() async {
  var android = new AndroidNotificationDetails(
    'id',
    'channel ',
    'description',
    priority: Priority.high,
    importance: Importance.max,
    playSound: true,
  );
  var iOS = new IOSNotificationDetails();
  var platform = new NotificationDetails(
    android: android,
    iOS: iOS,
    macOS: null,
  );
  await flutterLocalNotificationsPlugin.show(
    0,
    'Hey!',
    'It has been a while, let\'s catch up',
    platform,
    payload: 'Happened',
  );
}

Future<void> cancelNotification() async {
  await flutterLocalNotificationsPlugin.cancel(0);
}

class _BackgroundTaskState extends State<BackgroundTask> {
  @override
  void initState() {
    super.initState();
    main();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text('Background Tasks'),
          backgroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.watch_later_outlined,
                size: screenSize/3.5,
                color: Colors.amber,
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(screenSize / 30),
                  child: Text(
                    'Register a Reminder',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                    ),
                  ),
                ),
              ),
              PlatformEnabledButton(
                  platform: _Platform.android,
                  child: Text("Remind Now"),
                  onPressed: () {
                    Workmanager.registerOneOffTask(
                      "1",
                      updateNowTask,
                    );
                    print("Reminder successfully worked");
                    final snackBar =
                    SnackBar(content: Text("Reminder successfully worked"));
                    Scaffold.of(context).showSnackBar(snackBar);
                  }
              ),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(screenSize / 20),
                      child: Text(
                        'Select Frequency of Reminder',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              PlatformEnabledButton(
                  platform: _Platform.android,
                  child: Text("Remind Me Every 1 hour Periodically"),
                  onPressed: () async {
                    await Workmanager.cancelAll();
                    Workmanager.registerPeriodicTask(
                      "5",
                      updatePeriodic24HourTask,
                      frequency: Duration(hours: 1),
                    );
                    print("Reminder will be sent in every 1 hour starting now");
                    final snackBar =
                    SnackBar(content: Text("Reminder will be sent in every 1 hour starting from now"));
                    Scaffold.of(context).showSnackBar(snackBar);
                  }
              ),
              PlatformEnabledButton(
                  platform: _Platform.android,
                  child: Text("Remind Me Every 24 hours Periodically"),
                  onPressed: () async {
                    await Workmanager.cancelAll();
                    Workmanager.registerPeriodicTask(
                      "3",
                      simplePeriodicOneHourTask,
                      frequency: Duration(hours: 24),
                    );
                    print("Reminder will be sent in every 24 hours starting now");
                    final snackBar =
                    SnackBar(content: Text("Reminder will be sent in every 1 hour starting from now"));
                    Scaffold.of(context).showSnackBar(snackBar);
                  }
              ),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(screenSize / 20),
                      child: Text(
                        'Turn Off Reminder',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              PlatformEnabledButton(
                platform: _Platform.android,
                child: Text("Turn Off"),
                onPressed: () async {
                  await Workmanager.cancelAll();
                  print("Reminder cancelled");
                  final snackBar =
                  SnackBar(content: Text("From now on you won't get any reminding"));
                  Scaffold.of(context).showSnackBar(snackBar);
                },
              ),
            ],
          ),
        ),
    );
  }
}
