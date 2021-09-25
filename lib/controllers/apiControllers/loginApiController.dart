import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as pref;
import 'package:myalice/controllers/apiControllers/baseApiController.dart';
import 'package:myalice/models/responseModels/loginResponse.dart';

class LoginApiController extends BaseApiController {
  static String _loginPath = "accounts/login";
  static String _refreshPath = "accounts/refresh";
  static String _forgotPAssword = "accounts/request-password-reset";

  Future login(String email, String password) async {
    try {
      var response = await getDio()!.post(_loginPath, data: {
        'username': email,
        'password': password,
      });
      return LoginResponse.fromJson(response.data);
    } on DioError catch (e) {
      pref.Get.snackbar("Login Failed", e.response!.data["detail"],
          snackPosition: pref.SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: EdgeInsets.all(10));
    }
  }

  Future<dynamic> forgotPassword(String email) async {
    try {
      var response = await getDio()!.post(_forgotPAssword, data: {
        'email': email,
      });
      if (response.statusCode == 200) {
        return response.data["success"];
      }
    } on DioError catch (e) {
      pref.Get.snackbar("Error", e.response!.data["error"],
          snackPosition: pref.SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: EdgeInsets.all(10));
    }
  }

  Future<LoginResponse> refreshToken(String token) async {
    Response response =
        await getDio()!.post(_refreshPath, data: {'refresh': token});
    return LoginResponse.fromJson(response.data);
  }
}
