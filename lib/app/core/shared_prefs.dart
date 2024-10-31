import 'dart:collection';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OfflineData {
  final _token =
      "lkasdlsfsd"; // used this random string to make data untraceable
  final _session = "sdkfnlklas";
  final theme = "thkkjskjfbeme";
  final _isTestDb = "asdlfhlksdh";

  SharedPreferences sharedPreferences = Get.find<SharedPreferences>();

  static Future<SharedPreferences> getInstance() async {
    return await SharedPreferences.getInstance();
  }

  void setToken(String value) {
    sharedPreferences.setString(_token, value);
  }

  String getToken() {
    return sharedPreferences.getString(_token) ?? "";
  }

  String getTheme() {
    return sharedPreferences.getString(theme) ?? "";
  }

  void setTheme(String value) {
    sharedPreferences.setString(theme, value);
  }

  void setSession(Map session) {
    sharedPreferences.setString(_session, jsonEncode(session));
  }

  Map getSession() {
    String sessionString = sharedPreferences.getString(_session) ?? "{}";
    return jsonDecode(sessionString);
  }

  bool isTestDB() {
    return sharedPreferences.getBool(_isTestDb) ?? false;
  }

  void setTestDB(bool? value) {
    sharedPreferences.setBool(_isTestDb, value ?? false);
  }
}
