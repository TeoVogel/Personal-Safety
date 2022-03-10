import 'dart:async';

import 'package:flutter/material.dart';
import 'package:personal_safety/screens/emergency_contacts/emergency_contacts.dart';
import 'package:personal_safety/screens/homescreen/check_in_window_widget.dart';
import 'package:personal_safety/screens/homescreen/homescreen_drawer.dart';
import 'package:personal_safety/theme/colors.dart';

import '../../utils/checkin_time_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TimeOfDay? checkInTime;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    fetchCheckInData();

    // defines a timer
    _timer = Timer.periodic(Duration(seconds: 10), (Timer t) {
      fetchCheckInData();
    });
  }

  void fetchCheckInData() async {
    final TimeOfDay checkInTimePref = await getCheckInTime();
    setState(() {
      checkInTime = checkInTimePref;
    });
  }

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
              if (checkInTime != null)
                CheckInWindowWidget(checkInTimePref: checkInTime!),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EmergencyContacts(),
                    ),
                  ).then((val) {
                    fetchCheckInData();
                  });
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
