import 'package:flutter/material.dart';
import 'package:personal_safety/goBackButton.dart';

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
            color: const Color.fromARGB(255, 217, 229, 249),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OutlinedButton.icon(
                    onPressed: () {},
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
                      Text(
                        "Susan",
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
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
