import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import '../routes/app_pages.dart';

///Starting Point of app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "NonditoSoft",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
     // theme: CustomThemes.lightTheme(context),
    );
  }

}