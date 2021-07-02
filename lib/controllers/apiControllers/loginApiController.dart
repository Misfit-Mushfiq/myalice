import 'package:dio/dio.dart';
import 'package:myalice/controllers/apiControllers/baseApiControlleer.dart';
import 'package:myalice/models/responseModels/loginResponse.dart';

class LoginApiController extends BaseApiController {
  static String _loginPath = "accounts/login";

  Future<LoginResponse> login(String email, String password) async {
    Response response = await getDio()!.post(_loginPath,data: {
      'username':'raphhael@misfit.tech',
      'password':'raphael1234',
    });
    return LoginResponse.fromJson(response.data);
  }
}
