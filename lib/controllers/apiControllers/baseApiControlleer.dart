import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:myalice/controllers/apiControllers/interceptor.dart';
import 'package:myalice/utils/shared_pref.dart';

class BaseApiController extends GetxController {
  static const bool MODE_DEVELOPMENT = false;
  final SharedPref _sharedPref = SharedPref();

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
      headers: {
        _contentType: 'application/json',
        "Authorization": "Token eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjI1MzkxOTExLCJqdGkiOiIzMDMxY2FhOWZjM2E0ZDFkOTIxNmY0YmYxYzQ5NGMxNCIsInVzZXJfaWQiOjMzfQ.f2dtZX09Hpv_JYsygXeZlx9ogYIz5mS230PWjKuhi2U"
        },
    );

    _dio = Dio(dioOptions)..interceptors.add(LoggingInterceptors());
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
            "Received invalid status code: ${error.response!.statusCode}";
        break;
      case DioErrorType.sendTimeout:
        errorDescription = "Send timeout in connection with API server";
        break;
    }
    return errorDescription;
  }
}
