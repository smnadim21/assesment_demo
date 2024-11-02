import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nondito_soft_demo/app/core/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/core/shared_prefs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync<SharedPreferences>(() => OfflineData.getInstance(),
      permanent: true);
  runApp(const MyApp());
}
