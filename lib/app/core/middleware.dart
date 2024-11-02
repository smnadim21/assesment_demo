import 'package:nondito_soft_demo/app/core/shared_prefs.dart';

import '../../global_import.dart';

class AuthMiddleware extends GetMiddleware {
  final offlineData = Get.put(OfflineData());
  @override
  RouteSettings? redirect(String? route) {

    if( route == Routes.LOGIN) {
      return null;
    }
    return offlineData.getSession().isEmpty
        ? const RouteSettings(name: Routes.LOGIN)
        : null;
  }
}
