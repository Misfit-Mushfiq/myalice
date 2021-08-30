import 'package:flutter/material.dart';
import 'package:myalice/screens/loginScreen.dart';
import 'package:get/get.dart';


class ApiChecker {
  static void checkApi(BuildContext context, Response apiResponse) {
    if(apiResponse.statusCode==401) {

      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
    }else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(apiResponse.statusText!, style: TextStyle(color: Colors.white)), backgroundColor: Colors.red));
    }
  }
}