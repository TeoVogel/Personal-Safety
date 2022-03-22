import 'package:flutter/material.dart';
import 'package:personal_safety/utils/checkin_helper.dart';

class CheckInWidget extends StatefulWidget {
  const CheckInWidget({Key? key}) : super(key: key);

  @override
  State<CheckInWidget> createState() => _CheckInWidgetState();
}

class _CheckInWidgetState extends State<CheckInWidget> {
  @override
  void initState() {
    super.initState();
    checkIn();
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
