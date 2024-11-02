import 'package:nondito_soft_demo/app/core/shared_prefs.dart';

import '../../global_import.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final offlineData = Get.put(OfflineData());
    return offlineData.getSession().isEmpty || route == Routes.LOGIN
        ? null
        : const RouteSettings(name: Routes.LOGIN);
  }
}
