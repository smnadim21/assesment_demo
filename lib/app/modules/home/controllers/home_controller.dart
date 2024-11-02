import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nondito_soft_demo/app/data/user.dart';

import '../../../core/base_controller.dart';

class HomeController extends BaseController {
  RxBool search = RxBool(false);
  TextEditingController searchC = TextEditingController();

  List<NonditoUser> _fixedList = [];
  final RxList<NonditoUser> _filteredList = RxList([]);

  RxList<NonditoUser> get uList => _filteredList;

  RxBool reload = RxBool(false);

  set uList(List<NonditoUser> uList) {
    _filteredList.value = uList;
  }

  void filterUser(String str) {
    var filtered = _fixedList.where((p0) {
      return (p0.name?.toLowerCase().contains(str.toLowerCase()) ?? false) ||
          (p0.phone?.toLowerCase().contains(str.toLowerCase()) ?? false) ||
          (p0.email?.toLowerCase().contains(str.toLowerCase()) ?? false);
    }).toList();
    uList = (str.isEmpty ? _fixedList : filtered);
  }

  void setListData(List<NonditoUser>? data) {
    uList = data ?? [];
    _fixedList = data ?? [];
  }

  retry() async {
    reload.value = true;
    await fakeFuture(duration: 1);
    reload.value = false;
  }

}
