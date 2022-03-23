import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:personal_safety/utils/checkin_time_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'database_preferences.dart';

const lastCheckInKey = "last_check_in";

Future<bool> checkIn() async {
  final prefs = await SharedPreferences.getInstance();
  DateTime now = DateTime.now();
  prefs.setInt(lastCheckInKey, now.millisecondsSinceEpoch);

  DocumentReference userDocument =
      FirebaseFirestore.instance.collection('users').doc(await getUserId());
  return userDocument.update({'lastCheckIn': now}).then((value) {
    return true;
  }).catchError((error) {
    return false;
  });
}

Future<DateTime> getLastCheckIn() async {
  final prefs = await SharedPreferences.getInstance();
  final lastCheckInTime = prefs.getInt(lastCheckInKey) ?? 0;
  return DateTime.fromMillisecondsSinceEpoch(lastCheckInTime);
}

Future<bool> isTimeForCheckIn() async {
  final DateTime lastCheckIn = await getLastCheckIn();
  final DateTime currentOrUpcomingCheckIn =
      await getCurrentOrUpcomingCheckInWindowStartTime();
  final DateTime now = DateTime.now();

  // missed previous check-in
  if (lastCheckIn
      .isBefore(currentOrUpcomingCheckIn.subtract(Duration(days: 1)))) {
    return true;
  }

  return now.isAfter(currentOrUpcomingCheckIn) &&
      lastCheckIn.isBefore(currentOrUpcomingCheckIn);
}

Future<bool> isTimeForDexterityTest() async {
  if (!await isTimeForCheckIn()) {
    return false;
  }
  final DateTime currentOrUpcomingCheckIn =
      await getCurrentOrUpcomingCheckInWindowStartTime();
  final DateTime currentOrPreviousDexterityTest = currentOrUpcomingCheckIn
      .subtract(Duration(days: 1))
      .add(Duration(hours: checkInTimeDurationInHours));
  final DateTime now = DateTime.now();

  return _isBetween(
      now,
      currentOrPreviousDexterityTest,
      currentOrPreviousDexterityTest
          .add(Duration(hours: bufferPeriodDurationInHours)));
}

Future<DateTime> getCurrentOrUpcomingCheckInWindowStartTime() async {
  final TimeOfDay checkInPref = await getCheckInTime();
  final int checkInTime = checkInPref.hour * 100 + checkInPref.minute;

  DateTime now = DateTime.now();
  final int checkInHour = (checkInTime / 100).floor();
  final int checkInMinutes = checkInTime % 100;

  DateTime todayStartTime = DateTime(
    now.year,
    now.month,
    now.day,
    checkInHour,
    checkInMinutes,
  );
  const checkInDuration = Duration(hours: checkInTimeDurationInHours);
  const dayDuration = Duration(days: 1);
  DateTime todayEndTime = todayStartTime.add(checkInDuration);
  DateTime yesterdayStartTime = todayStartTime.subtract(dayDuration);
  DateTime yesterdayEndTime = todayEndTime.subtract(dayDuration);
  DateTime tomorrowStartTime = todayStartTime.add(dayDuration);

  if (_isBetween(now, todayStartTime, todayEndTime)) {
    return todayStartTime;
  } else if (_isBetween(now, yesterdayStartTime, yesterdayEndTime)) {
    return yesterdayStartTime;
  } else if (_isBetween(now, yesterdayEndTime, todayStartTime)) {
    return todayStartTime;
  } else {
    return tomorrowStartTime;
  }
}

bool _isBetween(DateTime date, DateTime betweenStart, DateTime betweenEnd) {
  return date.isAfter(betweenStart) && date.isBefore(betweenEnd);
}
