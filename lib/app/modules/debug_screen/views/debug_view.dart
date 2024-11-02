import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../../core/theme/colors.dart';
import '../../../core/theme/theme.dart';
import '../controllers/_controller.dart';

class DebugView extends GetView<DebugController> {
  const DebugView({super.key});

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
            return AppColor.colorSuccess;
          } else {
            return AppColor.colorDanger;
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
                  (args!['request'] == null ? "" : "\n\nREQUEST:") +
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
