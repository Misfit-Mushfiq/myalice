import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as pref;
import 'package:myalice/utils/routes.dart';

class LoggingInterceptors extends InterceptorsWrapper {
  int maxCharactersPerLine = 200;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint("--> ${options.method} ${options.baseUrl}${options.path}");
    debugPrint("Content type: ${options.contentType}");
    debugPrint("QueryParams: ${options.queryParameters}");
    debugPrint("QueryParams: ${options.headers}");
    debugPrint("Data: ${options.data}");
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint("<-- STATUS : ${response.statusCode}");
    String responseAsString = response.data.toString();
    if (responseAsString.length > maxCharactersPerLine) {
      int iterations = (responseAsString.length / maxCharactersPerLine).floor();
      for (int i = 0; i <= iterations; i++) {
        int endingIndex = i * maxCharactersPerLine + maxCharactersPerLine;
        if (endingIndex > responseAsString.length) {
          endingIndex = responseAsString.length;
        }
        debugPrint(
            responseAsString.substring(i * maxCharactersPerLine, endingIndex));
      }
    } else {
      debugPrint(response.data.toString());
    }
    debugPrint("<-- END HTTP");
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      pref.Get.offNamed(LOGIN_PAGE);
    }
    debugPrint(
        "ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.baseUrl}${err.requestOptions.path}");
    return super.onError(err, handler);
  }
}
