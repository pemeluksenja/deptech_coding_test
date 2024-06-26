import 'package:deptechcodingtest/data/local/database/eventDatabase.dart';
import 'package:deptechcodingtest/data/local/database/userDatabase.dart';
import 'package:deptechcodingtest/routes/app_pages.dart';
import 'package:deptechcodingtest/utils/SharedPreferences.dart';
import 'package:deptechcodingtest/utils/notificationService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sqflite/sqflite.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();

  tz.initializeTimeZones();
  final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(currentTimeZone));
  print("locationName: $currentTimeZone");

  final userDb = await openDatabase(UserDatabase.TABLE_NAME);
  final db = UserDatabase(userDb);

  final eventDb = await openDatabase(EventDatabase.TABLE_NAME);
  final eventdb = EventDatabase(eventDb);
  await initializeDateFormatting('id_ID', null)
      .then((_) => runApp(const MyApp()));
  await SharedPref.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Deptech Coding Test App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
