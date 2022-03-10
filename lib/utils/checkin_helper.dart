import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const lastCheckInKey = "last_check_in";

Future<void> checkIn() async {
  final prefs = await SharedPreferences.getInstance();
  await Future.delayed(const Duration(seconds: 5));
  int now = DateTime.now().millisecond;
  prefs.setInt(lastCheckInKey, now);
}

Future<DateTime> getLastCheckIn() async {
  final prefs = await SharedPreferences.getInstance();
  final lastCheckInTime = prefs.getInt(lastCheckInKey) ?? 0;
  return DateTime.fromMillisecondsSinceEpoch(lastCheckInTime);
}
