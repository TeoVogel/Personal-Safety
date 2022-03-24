import 'package:flutter/material.dart';
import 'package:personal_safety/utils/checkin_helper.dart';

import '../../utils/notification_service.dart';

class CheckInWidget extends StatefulWidget {
  const CheckInWidget({Key? key}) : super(key: key);

  @override
  State<CheckInWidget> createState() => _CheckInWidgetState();
}

class _CheckInWidgetState extends State<CheckInWidget> {
  @override
  void initState() {
    super.initState();
    checkIn().then((success) {
      if (success) {
        NotificationService().programDexterityTestNotifications();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Checked-in!'),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('No internet connection! Try again.'),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
