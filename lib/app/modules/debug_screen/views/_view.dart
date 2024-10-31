import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/colors.dart';
import '../controllers/_controller.dart';

extension StringExtension on String {
  String get prettyJson {
    try {
      if (isNotEmpty) {
        return const JsonEncoder.withIndent('  ').convert(json.decode(this));
      }
      return this;
    } on Exception catch (e, stack) {
      e.printError();
      stack.printError();
      return this;
    }
  }
}

extension MapExtension on Map {
  String get prettyJson {
    try {
      if (isNotEmpty) {
        return const JsonEncoder.withIndent('  ').convert(this);
      }
      return toString();
    } on Exception catch (e, stack) {
      e.printError();
      stack.printError();
      return toString();
    }
  }
}

class DebugView extends GetView<DebugController> {
  @override
  Widget build(BuildContext context) {
    var args = Get.arguments;
    // printJson(args.toString());
    return Scaffold(
      backgroundColor: LocalColors.text_color,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: () {
          if ((args!['code'] ?? 0) >= 200 && args!['code'] < 400) {
            return LocalColors.text_success;
          } else {
            return LocalColors.text_red;
          }
        }(),
        title: Text(args!['title'] ?? "DEBUG PAGE"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: SelectableText(
              args!['title'] +
                  (args!['route'] == null ? "" : "\n\nURL : ") +
                  (args!['route'] ?? "--") +
                  (args!['request'] == null ? "" : "\n\nREQUEST/BODY:") +
                  "\n\n" +
                  asPrettyJson(args!['request'] ?? "{}") +
                  (args!['data'] == null ? "" : "\n\n\nDATA/RESPONSE:") +
                  "\n\n" +
                  asPrettyJson((args!['data'] ?? "")),
              style: GoogleFonts.firaMono(
                  fontSize: 12, color: LocalColors.BACKGROUND)),
        ),
      ),
    );
  }

  String asPrettyJson(String incoming) {
    var prettyString = "";
    try {
      if (incoming != "") {
        prettyString =
            const JsonEncoder.withIndent('  ').convert(json.decode(incoming));
        return prettyString;
      }
    } on Exception catch (e, stack) {
      e.printError();
      stack.printError();
      return incoming;
    }
    return prettyString;
  }
}
