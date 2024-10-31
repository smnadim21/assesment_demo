import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:dio/dio.dart' as dio;


import '../shared_prefs.dart';
import '../ui/popups.dart';
import 'api_response.dart';

enum Method {
  GET('get'),
  POST("post");

  const Method(this.text);

  final String text;
}

class ApiProvider extends GetConnect {
  @override
  void onInit() {
    allowAutoSignedCert = true;
  }

  final offlineData = Get.put(OfflineData());

  ApiProvider() {
    timeout = const Duration(seconds: 10);
  }

  String get BASE_URL =>
      offlineData.isTestDB() ? "http://10.0.2.2:8082" : "http://10.0.2.2:8082";

  static const uuid = Uuid();

  getResponse<T>(
      {required Method method,
      String? baseUrl,
      required String route,
      Map<String, String>? queries,
      bool showError = false,
      bool receiveDataWhenStatusError = true,
      dynamic body,
      bool verbose = false}) async {
    String token = "await auth.getToken()";
    String url = baseUrl ?? BASE_URL;

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    if (method == Method.GET) {
      final resp = await dio.Dio().get(url + route,
          data: body,
          queryParameters: queries,
          options: dio.Options(
              headers: headers,
              receiveDataWhenStatusError: receiveDataWhenStatusError));

      DefaultDioResponse<T> response = DefaultDioResponse.from(resp);

      if (response.hasError) {
        log(response.errorMessage ?? "EMPTY ");
        //-------------- response is 404 ---------------------
        if (response.statusCode == 404) {
          response.errorMessage = "User Not Found";
        }
        //-------------- response is not 404 -----------------
        else {
          response.errorMessage =
              "${response.statusCode} ${response.statusText!}";
          //------------- response is 401 (UNAUTHORIZED) -------------------
          if (response.statusCode == 401) {
            //----------UNAUTHORIZED : go to Login Page
            offlineData.setSession({});
          }
        }
        if (showError) {
          if ((response.statusCode ?? 0) > 400) {
            PopUps.showError(
                error: "${response.errorMessage ?? ""} << error >>",
                verbose: true,
                route: url + route,
                code: response.statusCode,
                data: response.bodyString,
                request: json.encode(queries));
          }
        }
      } else {
        if (verbose) {
          PopUps.showError(
              error: response.errorMessage ?? "",
              verbose: true,
              route: url + route,
              code: response.statusCode,
              data: response.bodyString,
              request: json.encode(queries));
        }
      }
      return response;
    }
    if (method == Method.POST) {
      body = body ?? offlineData.getSession();
      String params =
          (queries == null ? '' : "?${dio.Transformer.urlEncodeMap(queries)}");
      //----------------- Fetching Response--------------------------

      final resp = await dio.Dio().post(url + route + params,
          data: body,
          options: dio.Options(
              headers: headers,
              receiveDataWhenStatusError: receiveDataWhenStatusError));

      DefaultDioResponse<T> response = DefaultDioResponse.from(resp);

      if (response.hasError) {
        log(response.errorMessage ?? "EMPTY ");
        //------------------ IF 404 ---------------------------------
        if (response.statusCode == 404) {
          response.errorMessage = "API Not Found";
        }
        //------------------ IF not 404 -----------------------------
        else {
          response.errorMessage =
              "${response.statusCode} ${response.statusText!}";

          //------------------ UNAUTHORIZED ----------------------
          if (response.statusCode == 401) {
            offlineData.setSession({});
          }
        }
        if (showError) {
          if ((response.statusCode ?? 0) > 400) {
            PopUps.showError(
                error: response.errorMessage ?? "",
                verbose: true,
                route: url + route + params,
                code: response.statusCode,
                data: response.bodyString,
                request: json.encode(body));
          }
        }
      } else {
        if (verbose) {
          PopUps.showError(
              error: response.errorMessage ?? "",
              verbose: true,
              route: url + route + params,
              code: response.statusCode,
              data: response.bodyString,
              request: json.encode(body));
        }
      }

      return response;
    }
  }
}
