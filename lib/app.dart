import 'package:flutter/material.dart';
import 'package:personal_safety/screens/homescreen/homescreen.dart';
import 'package:personal_safety/theme/themes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeUtils.myTheme,
      home: const HomeScreen(title: 'Personal Safety'),
    );
  }
}
