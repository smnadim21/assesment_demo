import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/colors.dart';
import '../theme/theme.dart';
import '../../routes/app_pages.dart';

class PopUps {
  static void showCustomDialog(
      {required BuildContext context,
      String? title,
      RxnString? value,
      List<String> items = const [],
      required Null Function(dynamic changed) onChanged}) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext cxt) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Material(
              color: Get.theme.colorScheme.surface,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(title ?? "Select Options"),
                    ),
                    Expanded(
                        child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          minVerticalPadding: 0,
                          title: Text(items[index]),
                          onTap: () {},
                          trailing: Obx(() => Radio<String>(
                                activeColor: LocalColors.TEXT_ABC_GREEN,
                                value: items[index],
                                groupValue: value?.value,
                                toggleable: true,
                                onChanged: onChanged,
                                // onChanged: (changed) {
                                //   value?.value = changed;
                                //   controller?.saveData();
                                //   Navigator.of(context).pop();
                                // },
                              )),
                        );
                        // return ListTile(
                        //   title: Text("SERVER OK"),
                        //   onTap: () {
                        //     snackOK("title", "content");
                        //   },
                        // );
                      },
                    )),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("CLOSE")),
                        /*                           const SizedBox(width: 16),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("SAVE")
                          ),*/
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  static void showDialogue(BuildContext context,
      {String? title,
      String? content,
      String? positiveButtonText,
      String? negativeButtonText,
      TextButton? actionOk,
      TextButton? actionCancel,
      bool hideCancelButton = false}) {
    //hideCancel = actionCancel == null;
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title ?? 'Title'),
        content: Text(content ?? 'AlertDialog description'),
        actions: <Widget>[
          Visibility(
            visible: !hideCancelButton,
            child: actionCancel ??
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: Text(negativeButtonText ?? 'Cancel'),
                ),
          ),
          actionOk ??
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: Text(positiveButtonText ?? 'OK'),
              ),
        ],
      ),
    );
  }

  static void showWidgetDialogue(BuildContext context, Widget? widget) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext cxt) {
        return widget ?? const SizedBox();
      },
    );
  }

  static void showError(
      {String? error,
      String title = "Error!",
      bool verbose = false,
      Widget? icon,
      int? code = -1,
      String? data = "",
      String? route = "--",
      String? request = "{}"}) {
    Get.dialog(Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        color: Get.theme.colorScheme.surface,
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 300,
                    width: 300,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("$error")),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Error: ${filterError(error ?? "")}",
                      style: const TextStyle(fontSize: 22),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                if (verbose) {
                  Get.back();
                  Get.toNamed(Routes.DEBUG, arguments: {
                    "title": title,
                    "code": code,
                    "route": route,
                    "data": data,
                    "request": request
                  });
                } else {
                  Get.back();
                }
              },
              child: Visibility(
                visible: true,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "View Details",
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Get.back();
              },
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "OK",
                  style: TextStyle(fontSize: 26, color: AppColor.colorDanger),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }

  static String? filterError(String error) {
    log(error);
    if (error.toLowerCase().contains("socketexception")) {
      return "Failed to connect to internet, please try again";
    }
    return error;
  }
}

class Snack {
  static void oK(String content, {String title = "Success", Widget? icon}) {
    Get.closeCurrentSnackbar();
    Get.snackbar(title, content,
        icon: icon,
        borderColor: Get.theme.colorScheme.onSurface,
        borderWidth: .3,
        snackPosition: SnackPosition.TOP,
        colorText: AppColor.textColor,
        backgroundColor: AppColor.bgwhite);
  }

  static void warn(String content, {String title = "Warn!", Widget? icon}) {
    Get.closeCurrentSnackbar();
    Get.snackbar(title, content,
        borderColor: Get.theme.colorScheme.onSurface,
        borderWidth: .3,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.black,
        backgroundColor: Colors.amber.shade300);
  }

  static void error(String content,
      {String title = "Error!",
        bool verbose = false,
        bool autoDismiss = false,
        Widget? icon,
        int? code = -1,
        String? data = "",
        String? route = "--",
        String? request = "{}"}) {
    Get.closeCurrentSnackbar();
    Get.snackbar(title, content,
        icon: icon,
        snackPosition: SnackPosition.BOTTOM,
        colorText: AppColor.colorDanger,
        borderColor: Get.theme.colorScheme.onSurface,
        borderWidth: .3,
        duration: Duration(seconds: autoDismiss ? 3 : 300),
        isDismissible: true,
        mainButton: TextButton(
            style: ButtonStyle(
                backgroundColor:
                WidgetStateProperty.all<Color>(AppColor.colorDanger)),
            onPressed: () {
              if (verbose) {
                Get.back();
                Get.toNamed(Routes.DEBUG, arguments: {
                  "title": title,
                  "code": code,
                  "route": route,
                  "data": data,
                  "request": request
                });
              } else {
                Get.back();
              }
            },
            child: Visibility(
              visible: !autoDismiss,
              child: Text(
                (verbose ? "Details" : "Close"),
                style: const TextStyle(color: AppColor.bgwhite),
              ),
            )),
        backgroundColor: Colors.white);
  }

  static void debug(String title, String content,
      {bool verbose = false,
        int? code = -1,
        String? data = "",
        String? route = "--",
        String? request = "{}"}) {
    Get.closeCurrentSnackbar();
    Get.snackbar(title, content,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.black,
        borderColor: Get.theme.colorScheme.onSurface,
        borderWidth: .3,
        duration: const Duration(seconds: 300),
        isDismissible: true,
        mainButton: TextButton(
            style: const ButtonStyle(
              //backgroundColor: MaterialStateProperty.all(LocalColors.text_blue),
            ),
            onPressed: () {
              if (verbose) {
                Get.back();
                Get.toNamed(Routes.DEBUG, arguments: {
                  "title": title,
                  "code": code,
                  "route": route,
                  "data": data,
                  "request": request
                });
              } else {
                Get.back();
              }
            },
            child: Text(
              (verbose ? "DETAILS" : "CLOSE"),
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            )),
        backgroundColor: LocalColors.text_blue_light);
  }
}
