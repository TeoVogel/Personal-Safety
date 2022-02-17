import 'package:flutter/material.dart';
import 'package:personal_safety/app.dart';
import 'package:personal_safety/utils/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init(); // <----
  runApp(const App());
}
