import 'package:flutter/cupertino.dart';

extension StringExt on String {
  String get asset => "assets/images/$this";

  AssetImage get assetImage => AssetImage("assets/images/$this");
}

extension IntegerExt on int {
  String get withZero {
    return this < 10 ? "0$this" : "$this";
  }
}
