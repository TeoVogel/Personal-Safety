import 'package:flutter/material.dart';
import 'package:personal_safety/emergencycontacts.dart';
import 'package:personal_safety/homescreenDrawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              /*Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center,
                ),
              ),*/
              Builder(
                builder: ((context) => OutlinedButton(
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(width: 24),
                          Spacer(),
                          Align(
                            alignment: Alignment.center,
                            child: Text("MORE OPTIONS"),
                          ),
                          Spacer(),
                          Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.menu,
                                size: 24,
                              )),
                        ],
                      ),
                    )),
              ),
              const Spacer(),
              const Icon(
                Icons.check,
                size: 200,
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EmergencyContacts(),
                    ),
                  );
                },
                child: const Text("EMERGENCY CONTACTS"),
              ),
            ],
          ),
        ),
      ),
      endDrawer: const HomeScreenDrawer(),
    );
  }
}
