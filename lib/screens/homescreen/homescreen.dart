import 'package:flutter/material.dart';
import 'package:personal_safety/screens/emergency_contacts/emergency_contacts.dart';
import 'package:personal_safety/screens/homescreen/homescreen_drawer.dart';
import 'package:personal_safety/theme/colors.dart';

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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(
                  Icons.check_circle_outline_outlined,
                  size: 250,
                  color: colorPrimary.withAlpha(125),
                ),
              ),
              Text(
                "You are set for the day!",
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              Text(
                "Next check-in:\nTomorrow 8:00AM to 9:00AM",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
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
