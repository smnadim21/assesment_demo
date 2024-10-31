import 'package:dio/dio.dart' as dio;
import 'package:get/get_connect/http/src/status/http_status.dart';

abstract class CustomDioResponse<T> {
  String? errorMessage;
  bool? isSuccessful;
  bool? loginNotVerified;
  DateTime? responseTime;
  T? result;

  dio.RequestOptions? requestOptions;
  Map<String, dynamic>? headers;
  int statusCode = 0;
  String? statusText;
  bool hasError = true;
  bool isOk = false;
  bool unauthorized = true;
  String? bodyString;
  dynamic body;
}

class DefaultDioResponse<T> extends CustomDioResponse<T> {
  DefaultDioResponse.from(dio.Response<dynamic> response) {
    statusCode = response.statusCode ?? 0;
    HttpStatus status = HttpStatus(statusCode);
    requestOptions = response.requestOptions;
    headers = response.requestOptions.headers;
    statusText = response.statusMessage;
    hasError = status.hasError;
    isOk = status.isOk;
    isSuccessful = status.isOk;
    unauthorized = status.isUnauthorized;
    loginNotVerified = !status.isUnauthorized;
    bodyString = response.data.toString();
    body = response.data;
    responseTime = DateTime.now();
    errorMessage = "$statusCode ${statusText}";
  }
}
