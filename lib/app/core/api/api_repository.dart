
import 'package:nondito_soft_demo/app/data/user.dart';

import '/app/modules/debug_screen/views/_view.dart';
import 'package:get/get.dart';

import 'api_provider.dart';
import 'api_response.dart';

class ApiRoutes {
  final String login = "/api/login";
  final users = "/users";

  String userById(int id) => "/users/$id";
}

class ApiRepository {
  final apiProvider = Get.put(ApiProvider());
  final apiRoutes = Get.put(ApiRoutes());

  Future<DefaultDioResponse> login(
      {required String email, required String password}) async {
    DefaultDioResponse response = await apiProvider.getResponse(
        method: Method.POST,
        baseUrl: "https://reqres.in",
        route: apiRoutes.login,
        body: {'email': email, 'password': password});

    var value = response.body['token'] ?? "";
    Map data = response.body ?? {};
    apiProvider.offlineData.setToken(value);
    apiProvider.offlineData.setSession(data);
    print(data.prettyJson);
    return response;
  }

  Future<List<NonditoUser>> getUsers() async {
    DefaultDioResponse response = await apiProvider.getResponse(
      method: Method.GET,
      route: apiRoutes.users,
      baseUrl: "https://jsonplaceholder.typicode.com",
    );
    List userList = response.body ?? [];
    List<NonditoUser> nonditoUsers =
        userList.map((user) => NonditoUser.fromJson(user)).toList();
    return nonditoUsers;
  }

  Future<NonditoUser> getUserById({required int id}) async {
    DefaultDioResponse response = await apiProvider.getResponse(
      method: Method.GET,
      route: apiRoutes.userById(id),
      baseUrl: "https://jsonplaceholder.typicode.com",
    );
    Map<String, dynamic> user = response.body ?? {};
    NonditoUser nonditoUser = NonditoUser.fromJson(user);
    return nonditoUser;
  }
}
