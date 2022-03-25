import 'package:flutter/material.dart';
import 'package:personal_safety/screens/homescreen/homescreen.dart';
import 'package:personal_safety/screens/log_in/log_in_screen.dart';
import 'package:personal_safety/theme/themes.dart';
import 'package:personal_safety/utils/log_in_preferences.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perdiem',
      theme: ThemeUtils.myTheme,
      home: FutureBuilder(
        future: isUserLoggedIn(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!) {
              return const HomeScreen(title: 'Perdiem');
            } else {
              return const LogInScreen();
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
