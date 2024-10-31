import 'dart:collection';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OfflineData {
  final token = "token";
  final theme = "theme";
  final String cookie = "cookie";
  final String odoo = "odoo";
  final String adr1 = "adr1";
  final String adr2 = "adr2";
  final String geo = "geo";
  final String _userInfo = "wwwslkasfifo";
  final String _userId = "ufgakjjdfhh";
  final String _tokenResponse = "eyjakjgfsf";
  final String _credential = "creyjakjgfsf";
  final String _isTestDb = "istsjabfa";
  final String _isOdooTestDb = "istsoodjabfa";
  final String _searchHistory = "slkseahtirypp";
  SharedPreferences sharedPreferences = Get.find<SharedPreferences>();

  static Future<SharedPreferences> getInstance() async {
    return await SharedPreferences.getInstance();
  }

  void setToken(String value) {
    sharedPreferences.setString(token, value);
  }

  String getToken() {
    return sharedPreferences.getString(token) ?? "";
  }

  String getTheme() {
    return sharedPreferences.getString(theme) ?? "";
  }

  void setTheme(String value) {
    sharedPreferences.setString(theme, value);
  }

  void setSession(Map session) {
    sharedPreferences.setString(_userInfo, jsonEncode(session));
  }

  Map getSession() {
   return jsonDecode( sharedPreferences.getString(_userInfo)??"{}");
  }

  void setOdoo(bool value) {
    sharedPreferences.setBool(odoo, value);
  }

  void setAdr1(String value) {
    sharedPreferences.setString(adr1, value);
  }

  void setAdr2(String value) {
    sharedPreferences.setString(odoo, value);
  }

  void setGeo(String value) {
    print("LTLNG >> $value");
    sharedPreferences.setString(geo, value);
  }

  String? getGeo() {
    String? geoS = sharedPreferences.getString(geo);
    print(geoS);
    return geoS;
  }

  bool isOdooLoggedIn() {
    return sharedPreferences.getBool(odoo) ?? false;
  }

  String getCookie() {
    return sharedPreferences.getString(cookie) ??
        "session_id=41de13aa7c5fd27f22353e94c3596f77b50e7e82";
  }

  void setCookie(String? value) {
    sharedPreferences.setString(
        cookie, value ?? "session_id=41de13aa7c5fd27f22353e94c3596f77b50e7e82");
  }

  bool isTestDB() {
    return sharedPreferences.getBool(_isTestDb) ?? false;
  }

  void setTestDB(bool? value) {
    sharedPreferences.setBool(_isTestDb, value ?? false);
  }

  bool isOdooTestDB() {
    return sharedPreferences.getBool(_isOdooTestDb) ?? false;
  }

  void setOdooTestDB(bool? value) {
    sharedPreferences.setBool(_isOdooTestDb, value ?? false);
  }

  setUserId(int uid) {
    sharedPreferences.setInt(_userId, uid ?? 1);
  }

  int getUserId() {
    return sharedPreferences.getInt(_userId) ?? 1;
  }

  void setSearchHistory(ListQueue<String> listQueue) {
    String tobeSaved = jsonEncode(listQueue.toList());
    sharedPreferences.setString(_searchHistory, tobeSaved);
  }

  ListQueue<String> getSearchHistory() {
    ListQueue<String> listQueue = ListQueue(5);
    String getSaved = sharedPreferences.getString(_searchHistory) ?? "[]";
    List<String> data =
    (jsonDecode(getSaved) as List).map((e) => e.toString()).toList();
    listQueue.addAll(data);
    return listQueue;
  }}
