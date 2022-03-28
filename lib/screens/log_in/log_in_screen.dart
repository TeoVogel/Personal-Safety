import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:personal_safety/screens/homescreen/homescreen.dart';
import 'package:personal_safety/theme/colors.dart';
import 'package:personal_safety/utils/checkin_time_preferences.dart';
import 'package:personal_safety/utils/log_in_preferences.dart';

import '../../utils/notification_service.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final myController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  Future<void> logIn() async {
    //if (_formKey.currentState!.validate()) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(myController.text)
        .get();

    if (!userSnapshot.exists) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Invalid user ID. Try again'),
      ));
    } else {
      setUserId(myController.text);
      setUserLoggedIn(true);
      setCheckInTime(await getCheckInTime()).then((success) {
        final notificationService = NotificationService();
        if (success) {
          notificationService.programCheckInNotification();
          notificationService.programDexterityTestNotifications();
        }
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(title: "Perdiem"),
        ),
      );
      //}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPrimary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  SizedBox(height: 100),
                  SizedBox(
                      height: 100,
                      child: Image(image: AssetImage('assets/splash.png'))),
                ],
              ),
              Center(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text("Welcome! Enter your user ID:",
                            style: Theme.of(context).textTheme.subtitle2),
                        const SizedBox(height: 10),
                        TextFormField(
                          key: _formKey,
                          controller: myController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "The ID can't be empty";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: logIn,
                          child: const Text("LOG IN"),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
