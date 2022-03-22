import 'package:shared_preferences/shared_preferences.dart';

const userIdKey = "user_id";

Future<String> getUserId() async {
  return "a30wukbMEsxamPqV0G1w";
}

void setUserId(String userId) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(userIdKey, userId);
}
