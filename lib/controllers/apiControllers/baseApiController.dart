import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/interceptor.dart';

class BaseApiController extends GetxController with StateMixin<dynamic> {
  static const bool MODE_DEVELOPMENT = false;

  static const String _baseUrl = MODE_DEVELOPMENT == true
      ? 'https://v3stage.getalice.ai/api/'
      : 'https://v3stage.getalice.ai/api/';

  static const String _contentType = 'Content-Type';
  //static const String _xAuthorization = 'X-Authorization';

  /*  static const String _xAuthorizationKeyAndroidApp = MODE_DEVELOPMENT == true
      ? '9dZ24lz9WC7VkfeQhxpYM4Wn6sKaENxGxihZN2wqdBroK6f5FzuRIiFddRqanbgu'
      : '9dZ24lz9WC7VkfeQhxpYM4Wn6sKaENxGxihZN2wqdBroK6f5FzuRIiFddRqanbgu';

  static const String _xAuthorizationKeyIosApp = MODE_DEVELOPMENT == true
      ? '9dZ24lz9WC7VkfeQhxpYM4Wn6sKaENxGxihZN2wqdBroK6f5FzuRIiFddRqanbgu'
      : 'wlnqsSkIilb34YGpcVAXAHjdvsKHNIIIJZZkQNuo2CELkhRmjlc4wOHni1bMUHA1'; */

/*   static String getXAuthorizationKey = getAppWiseXAuthorizationKey();

  static String getAppWiseXAuthorizationKey() {
    return Platform.isAndroid == true
        ? _xAuthorizationKeyAndroidApp
        : _xAuthorizationKeyIosApp;
  } */

  Dio? _dio = Dio();

  BaseApiController() {
    BaseOptions dioOptions = BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: 30000,
      receiveTimeout: 60000,
      headers: {_contentType: 'application/json'},
    );

    _dio = Dio(dioOptions)
      ..interceptors.add(LoggingInterceptors(
        dio: getDio()!,
        requestRetrier: DioConnectivityRequestRetrier(
            dio: getDio()!, connectivity: Connectivity()),
      ));
  }

  Dio? getDio() => _dio;

  String handleError(DioError error) {
    String errorDescription = "";

    switch (error.type) {
      case DioErrorType.cancel:
        errorDescription = "Request to API server was cancelled";
        break;
      case DioErrorType.connectTimeout:
        errorDescription = "Connection timeout with API server";
        break;
      case DioErrorType.other:
        errorDescription =
            "Connection to API server failed due to internet connection";
        break;
      case DioErrorType.receiveTimeout:
        errorDescription = "Receive timeout in connection with API server";
        break;
      case DioErrorType.response:
        errorDescription =
            "Received status code: ${error.response!.statusCode}";
        break;
      case DioErrorType.sendTimeout:
        errorDescription = "Send timeout in connection with API server";
        break;
    }
    return errorDescription;
  }
}
