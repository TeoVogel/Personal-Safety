import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const checkInTimeKey = "check_in_time";
const checkInTimeDefaultValue = 700; // 7:00 AM
const checkInTimeDurationInHours = 3;
const bufferPeriodDurationInHours = 1;

Future<TimeOfDay> getCheckInTime() async {
  final int time = await _getCheckInTime();
  final int timeHours = (time / 100).floor();
  final int timeMinutes = time % 100;
  return TimeOfDay(hour: timeHours, minute: timeMinutes);
}

Future<TimeOfDay> getBufferWindowTime() async {
  final int time = await _getCheckInTime();
  final int timeHours =
      ((time / 100).floor() + checkInTimeDurationInHours) % 24;
  final int timeMinutes = time % 100;
  return TimeOfDay(hour: timeHours, minute: timeMinutes);
}

Future<TimeOfDay> getEmergencyWindowTime() async {
  final int time = await _getCheckInTime();
  final int timeHours = ((time / 100).floor() +
          checkInTimeDurationInHours +
          bufferPeriodDurationInHours) %
      24;
  final int timeMinutes = time % 100;
  return TimeOfDay(hour: timeHours, minute: timeMinutes);
}

Future<int> _getCheckInTime() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt(checkInTimeKey) ?? checkInTimeDefaultValue;
}

void setCheckInTime(TimeOfDay checkInTime) async {
  final prefs = await SharedPreferences.getInstance();
  int time = checkInTime.hour * 100 + checkInTime.minute;
  await prefs.setInt(checkInTimeKey, time);
}
