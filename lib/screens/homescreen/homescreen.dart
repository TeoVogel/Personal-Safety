import 'dart:async';

import 'package:flutter/material.dart';
import 'package:personal_safety/screens/emergency_contacts/emergency_contacts.dart';
import 'package:personal_safety/screens/homescreen/check_in_widget.dart';
import 'package:personal_safety/screens/homescreen/checked_in_widget.dart';
import 'package:personal_safety/screens/homescreen/homescreen_drawer.dart';
import 'package:personal_safety/screens/test/dexterity_test_widget.dart';
import 'package:personal_safety/utils/checkin_helper.dart' as checkin_helper;
import 'package:personal_safety/utils/database_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool initialized = false;
  late String userId;
  bool isTimeForCheckIn = false;
  bool isTimeForDexterityTest = false;
  late DateTime nextCheckIn;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    fetchCheckInData();

    // defines a timer
    _timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
      fetchCheckInData();
    });
  }

  void fetchCheckInData() async {
    final isTimeForCheckIn = await checkin_helper.isTimeForCheckIn();
    final isTimeForDexterityTest =
        await checkin_helper.isTimeForDexterityTest();
    final nextCheckIn =
        await checkin_helper.getCurrentOrUpcomingCheckInWindowStartTime();
    final userId = await getUserId();
    setState(() {
      initialized = true;
      this.userId = userId;
      this.isTimeForCheckIn = isTimeForCheckIn;
      this.isTimeForDexterityTest = isTimeForDexterityTest;
      this.nextCheckIn = nextCheckIn;
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
              if (!isTimeForDexterityTest)
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
              if (!initialized)
                const Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (isTimeForCheckIn)
                const CheckInWidget()
              else if (isTimeForDexterityTest)
                const DexterityTestWidget()
              else
                CheckedInWidget(nextCheckIn: nextCheckIn),
              const Spacer(),
              if (!isTimeForDexterityTest)
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EmergencyContacts(userId: userId),
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
