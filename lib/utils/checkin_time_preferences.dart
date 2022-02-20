import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const checkInTimeKey = "check_in_time";
const checkInTimeDefaultValue = 700; // 7:00 AM

Future<TimeOfDay> getCheckInTime() async {
  final prefs = await SharedPreferences.getInstance();
  final int time = prefs.getInt(checkInTimeKey) ?? checkInTimeDefaultValue;
  final int timeHours = (time / 100).floor();
  final int timeMinutes = time % 100;
  return TimeOfDay(hour: timeHours, minute: timeMinutes);
}

void setCheckInTime(TimeOfDay checkInTime) async {
  final prefs = await SharedPreferences.getInstance();
  int time = checkInTime.hour * 100 + checkInTime.minute;
  await prefs.setInt(checkInTimeKey, time);
}
