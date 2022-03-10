import 'package:flutter/material.dart';
import 'package:personal_safety/theme/colors.dart';

import '../../utils/checkin_time_preferences.dart';

class CheckInWindowWidget extends StatelessWidget {
  const CheckInWindowWidget({Key? key, required this.checkInTimePref})
      : super(key: key);

  final TimeOfDay checkInTimePref;

  String getCheckInTimeLabel() {
    final minutesLabel = checkInTimePref.minute == 0
        ? "00"
        : checkInTimePref.minute < 10
            ? "0${checkInTimePref.minute}"
            : "${checkInTimePref.minute}";
    return "${checkInTimePref.hour}:$minutesLabel";
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
          "Next check-in:\nTomorrow ${getCheckInTimeLabel()}",
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
