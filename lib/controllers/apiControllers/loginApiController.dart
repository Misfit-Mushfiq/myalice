import 'package:dio/dio.dart';
import 'package:myalice/controllers/apiControllers/baseApiController.dart';
import 'package:myalice/models/responseModels/loginResponse.dart';

class LoginApiController extends BaseApiController {
  static String _loginPath = "accounts/login";
  static String _refreshPath = "accounts/refresh";

  Future<LoginResponse> login(String email, String password) async {
    Response response = await getDio()!.post(_loginPath, data: {
      'username': email /* 'raphhael@misfit.tech' */,
      'password': password /*'raphael1234'*/,
    });
    return LoginResponse.fromJson(response.data);
  }

  Future<LoginResponse> refreshToken(String token) async {
    Response response =
        await getDio()!.post(_refreshPath, data: {'refresh': token});
    return LoginResponse.fromJson(response.data);
  }
}
