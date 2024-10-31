import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

class CustomThemes {
  static get themeColorDark => AppColor.colorBrand;

  static get themeColorLight => AppColor.colorBrand;

  static ThemeData lightTheme() {
    return ThemeData(
      indicatorColor: themeColorDark,
      primarySwatch: createMaterialColor(AppColor.colorPrimary),
      appBarTheme: const AppBarTheme(
          backgroundColor: AppColor.appBarBg,
          elevation: 0,
          titleSpacing: 0,
          titleTextStyle: TextStyle(
              color: AppColor.textColor,
              fontSize: 22,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w500),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppColor.colorPrimary,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light,
            systemNavigationBarColor: AppColor.colorPrimary,
          ),
          iconTheme: IconThemeData(color: AppColor.appBarIconColor)),
      scaffoldBackgroundColor: LocalColors.bg_white,
      fontFamily: "Poppins",
      colorScheme: ColorScheme.light(
        primary: themeColorLight,
        secondary: themeColorLight,
        surface: LocalColors.BACKGROUND,
      ),
      cardTheme:
          const CardTheme(elevation: 0, shadowColor: AppColor.colorPrimary),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
        indicatorColor: themeColorDark,
        primarySwatch: createMaterialColor(themeColorDark),
        colorScheme: ColorScheme.dark(
          primary: themeColorDark,
          secondary: themeColorDark,
          surface: LocalColors.BACKGROUND_Dark,
          error: createMaterialColor(themeColorDark).shade700,
        ),
        appBarTheme: const AppBarTheme(
            backgroundColor: LocalColors.appbar_bg,
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: AppColor.colorPrimary,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.light,
              systemNavigationBarColor: AppColor.colorPrimary,
            ),
            iconTheme: IconThemeData(color: LocalColors.text_muted)));
  }

  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}

class AppColor {
  static const colorBrand = Color(0xFFf69a37);

  static const colorPrimary = colorBrand;
  static const colorPrimaryBg = LocalColors.text_blue_light;
  static const textColor = LocalColors.text_color;
  static const colorDanger = LocalColors.text_red;
  static const colorDangerBg = LocalColors.text_red_light;
  static const colorSuccess = LocalColors.text_green;
  static const colorSuccessBg = LocalColors.text_green_light;
  static const colorInfo = LocalColors.text_purple;
  static const colorInfoBg = LocalColors.text_purple_light;
  static const colorWarn = LocalColors.text_yellow;
  static const colorWarnBg = LocalColors.text_yellow_light;
  static const appBarIconColor = colorBrand;

  static const appBarBg = Colors.white;

  static const colorBorderSide = Color(0xFFE9E9E9);

/*  static const secondaryBlue_50 = Color(0xffE6F5FB);
  static const secondaryBlue_75 = Color(0xff96D5EF);
  static const secondaryBlue_100 = Color(0xff6BC3E8);
  static const secondaryBlue_200 = Color(0xff2BAADF);
  static const secondaryBlue_300 = Color(0xff0098D8);
  static const secondaryBlue_400 = Color(0xff006A97);
  static const secondaryBlue_500 = Color(0xff005D84);

  static const primaryBlue_50 = Color(0xfffbfbfb);
  static const primaryBlue_75 = Color(0xff97B2C8);
  static const primaryBlue_100 = Color(0xff6C91B1);
  static const primaryBlue_200 = Color(0xff2C6290);
  static const primaryBlue_300 = Color(0xff014279);
  static const primaryBlue_400 = Color(0xff012E55);
  static const primaryBlue_500 = Color(0xff01284A);

  static const blackGrey_50 = Color(0xffe9e9e9);
  static const blackGrey_75 = Color(0xffc8c8c8);
  static const blackGrey_100 = Color(0xff7f7d7e);
  static const blackGrey_200 = Color(0xff484546);
  static const blackGrey_300 = Color(0xff231F20);
  static const blackGrey_400 = Color(0xff191616);
  static const blackGrey_500 = Color(0xff151314);

  static const borderBlue = secondaryBlue_75;
  static const expansionTileBg = secondaryBlue_50;
  static const scaffoldColor = primaryBlue_50;*/
  static const underlineColor = Color(0xffb4b4b4);

  static const buttonBgColor = colorPrimary;

  static const colorBorderSideFocused = Color(0xFF9E9E9E);

  static const formLabelColor = Color(0xFF9E9E9E);

  static const authAppbarTitleColor = Color(0xFF2D2D2D);

  static const colorBorderSideError = Colors.red;

  static const bgwhite = Colors.white;
}
