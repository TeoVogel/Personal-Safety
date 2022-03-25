import 'package:shared_preferences/shared_preferences.dart';

const loggedInKey = "logged_in";
const userIdKey = "user_id";

Future<bool> isUserLoggedIn() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(loggedInKey) ?? false;
}

void setUserLoggedIn(bool value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(loggedInKey, value);
}

Future<String> getUserId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(userIdKey) ?? "a30wukbMEsxamPqV0G1w";
}

void setUserId(String userId) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(userIdKey, userId);
}
