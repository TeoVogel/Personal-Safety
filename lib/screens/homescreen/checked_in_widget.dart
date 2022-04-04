import 'package:flutter/material.dart';
import 'package:personal_safety/theme/colors.dart';
import 'package:personal_safety/utils/checkin_time_preferences.dart';

class CheckedInWidget extends StatelessWidget {
  const CheckedInWidget({Key? key, required this.nextCheckIn})
      : super(key: key);

  final DateTime nextCheckIn;

  String getCheckInTimeLabel() {
    DateTime nextCheckIn = this.nextCheckIn;
    DateTime now = DateTime.now();
    String dayLabel = "Tomorrow";
    if (now.isAfter(nextCheckIn)) {
      nextCheckIn = nextCheckIn.add(const Duration(days: 1));
    }
    if (now.day == nextCheckIn.day) {
      dayLabel = "Today";
    }
    final minutesLabel = nextCheckIn.minute == 0
        ? "00"
        : nextCheckIn.minute < 10
            ? "0${nextCheckIn.minute}"
            : "${nextCheckIn.minute}";
    return "$dayLabel ${nextCheckIn.hour}:$minutesLabel";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Icon(
            Icons.check_circle_outline_outlined,
            size: 250,
            color: colorPrimary40,
          ),
        ),
        Text(
          "You are checked-in!",
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 24),
        Text(
          "Next check-in:\n${getCheckInTimeLabel()}",
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontWeight: FontWeight.normal),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
