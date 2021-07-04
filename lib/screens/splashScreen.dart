import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myalice/utils/constant_strings.dart';
import 'package:myalice/utils/shared_pref.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SharedPref _sharedPref = SharedPref();

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      _sharedPref.readString("apiToken") != null
          ? Get.offNamed(CHAT_DETAILS_PAGE)
          : Get.offNamed(LOGIN_PAGE);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: SPLASH_SCREEN_BACKGROUND,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Image(
              image:
                  AssetImage('assets/launch_icon/myalice_white_trnsprnt.png'),
            )),
            Text(ALICE_LABS,
                style: TextStyle(color: Colors.white, fontSize: 20)),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
