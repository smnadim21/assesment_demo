import 'package:get/get.dart';
import '../controllers/_controller.dart';

class DebugBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DebugController>(() => DebugController());
  }
}
