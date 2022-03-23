import 'package:flutter/material.dart';
import 'package:personal_safety/screens/test/dexterity_test_screen.dart';
import 'package:personal_safety/theme/colors.dart';
import 'package:personal_safety/utils/database_preferences.dart';
import 'package:personal_safety/widgets/go_back_button.dart';
import 'package:personal_safety/utils/notification_service.dart';

import '../settings/settings_screen.dart';

class HomeScreenDrawer extends StatelessWidget {
  const HomeScreenDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: GoBackButton(),
            ),
          ),
          const Spacer(),
          Container(
            color: colorPrimary20,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingsScreen(),
                        ),
                      );
                    },
                    label: const Text("SETTINGS"),
                    icon: const Icon(Icons.settings_outlined),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(
                          Icons.person,
                          size: 32,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      FutureBuilder(
                          future: getUserId(),
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.data!,
                                style: Theme.of(context).textTheme.subtitle2,
                              );
                            }
                            return Text(
                              "",
                              style: Theme.of(context).textTheme.subtitle2,
                            );
                          }),
                    ],
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
