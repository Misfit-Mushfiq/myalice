import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as pref;
import 'package:myalice/utils/shared_pref.dart';

class LoggingInterceptors extends InterceptorsWrapper {
  int maxCharactersPerLine = 200;
  SharedPref _sharedPref = SharedPref();
  late DioConnectivityRequestRetrier requestRetrier;
  final Dio dio;

  LoggingInterceptors({required this.dio, required this.requestRetrier});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint("--> ${options.method} ${options.baseUrl}${options.path}");
    debugPrint("Content type: ${options.contentType}");
    debugPrint("QueryParams: ${options.queryParameters}");
    debugPrint("Headers: ${options.headers}");
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
  Future onError(DioError error, ErrorInterceptorHandler handler) async {
    debugPrint(
        "ERROR[${error.response?.statusCode}] => PATH: ${error.requestOptions.baseUrl}${error.requestOptions.path}");

    if (error.response!.statusCode == 401) {
      String refreshToken =
          await _sharedPref.readString("apiRefreshToken") ?? "";
      if (refreshToken.isNotEmpty) {
        Dio tokenDio = new Dio();
        Options options = Options(
            method: error.requestOptions.method,
            sendTimeout: error.requestOptions.sendTimeout,
            receiveTimeout: error.requestOptions.receiveTimeout,
            extra: error.requestOptions.extra,
            headers: error.requestOptions.headers,
            responseType: error.requestOptions.responseType,
            contentType: error.requestOptions.contentType);
        tokenDio.interceptors.add(LogInterceptor(
            responseBody: true, requestHeader: true, requestBody: true));
        return await tokenDio
            .post("https://v3stage.getalice.ai/api/accounts/refresh",
                data: {'refresh': refreshToken})
            .then((d) {
              //update Token
              error.requestOptions.headers["Authorization"] =
                  "Token " + d.data["access"];
              _sharedPref.saveString("apiToken", d.data["access"]);
            })
            .catchError((onError) {})
            .then((e) async {
              //repeat
              final response = await tokenDio.request(
                  error.requestOptions.baseUrl + error.requestOptions.path,
                  data: error.requestOptions.data,
                  cancelToken: error.requestOptions.cancelToken,
                  onReceiveProgress: error.requestOptions.onReceiveProgress,
                  onSendProgress: error.requestOptions.onSendProgress,
                  queryParameters: error.requestOptions.queryParameters,
                  options: options);

              return handler.resolve(response);
            });
      } else {
        return super.onError(error, handler);
      }
    } else
     return super.onError(error, handler);
  }

  bool _shouldRetry(DioError err) {
    return err.type == DioErrorType.other &&
        err.error != null &&
        err.error is SocketException;
  }
}

class DioConnectivityRequestRetrier {
  final Dio dio;
  final Connectivity connectivity;

  DioConnectivityRequestRetrier({
    required this.dio,
    required this.connectivity,
  });

  Future<Response> scheduleRequestRetry(RequestOptions requestOptions) async {
    var streamSubscription;
    final responseCompleter = Completer<Response>();

    streamSubscription = connectivity.onConnectivityChanged.listen(
      (connectivityResult) async {
        print(connectivityResult);
        if (connectivityResult != ConnectivityResult.none) {
          streamSubscription.cancel();
          responseCompleter.complete(dio.request(
            requestOptions.baseUrl + requestOptions.path,
            cancelToken: requestOptions.cancelToken,
            data: requestOptions.data,
            onReceiveProgress: requestOptions.onReceiveProgress,
            onSendProgress: requestOptions.onSendProgress,
            queryParameters: requestOptions.queryParameters,
            options: Options(
                method: requestOptions.method,
                sendTimeout: requestOptions.sendTimeout,
                receiveTimeout: requestOptions.receiveTimeout,
                extra: requestOptions.extra,
                headers: requestOptions.headers,
                responseType: requestOptions.responseType,
                contentType: requestOptions.contentType),
          ));
        }
      },
    );
    return responseCompleter.future;
  }
}
