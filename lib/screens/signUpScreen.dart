import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myalice/utils/colors.dart';
import 'package:myalice/utils/constant_strings.dart';
import 'package:myalice/utils/routes.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white,
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Image.asset("assets/launch_icon/signUp.gif", height: 300),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(SIGNUP_SCREEN_INFO,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, height: 1.5)),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  SIGNUP_SCREEN_BOTTOM_TEXT,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                      height: 1.5),
                ),
              ),
              SizedBox(height: 12),
              GestureDetector(
                child: Text(
                  'Back to Sign In',
                  style: TextStyle(
                      color: AliceColors.ALICE_BLUE,
                      decoration: TextDecoration.underline),
                ),
                onTap: () {
                  Get.offAllNamed(LOGIN_PAGE);
                },
              )
            ],
          )),
    );
  }
}
