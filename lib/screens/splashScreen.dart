import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myalice/utils/constant_strings.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Get.offNamed(LOGIN_PAGE);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
