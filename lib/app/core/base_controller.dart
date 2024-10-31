import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'api/api_repository.dart';
import 'shared_prefs.dart';

abstract class BaseController extends SuperController {
  final offlineData = Get.put(OfflineData());
  final api = Get.put(ApiRepository());
  dynamic args = Get.arguments ?? {};
  RxString pageTitle = RxString("NonditoSoft Demo");
  RxnString subTitle = RxnString();
  RxBool busy = RxBool(false);
  final formKey = GlobalKey<FormState>();
  Object? data;


  @override
  void onInit() {
    args = Get.arguments;
    pageTitle.value = args != null ? args["title"] ?? "" : "";
    subTitle.value = args != null ? args["subtitle"] : null;
    super.onInit();
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}

  @override
  void onHidden() {}

  startLoader() {
    busy.value = true;
  }

  stopLoader() {
    busy.value = false;
  }

  void hideKeyBoard() {
    FocusManager.instance.primaryFocus?.unfocus();
    FocusScope.of(Get.context!).unfocus();
  }

  Future<List<String>> fakeFuture({int? duration}) async {
    await Future.delayed(Duration(seconds: duration ?? 3));
    return ["fakeFuture1", "fakeFuture2", "fakeFuture3"];
  }

  notImplemented() {
    //Snack.warn("Not Implemented Yet");
  }
}
