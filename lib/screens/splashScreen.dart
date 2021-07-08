import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myalice/screens/first.dart';
import 'package:myalice/utils/constant_strings.dart';
import 'package:myalice/utils/shared_pref.dart';
import 'package:myalice/utils/colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? token;

  @override
  void initState() {
    whichScreenToNavigate();
    super.initState();
  }

  Future<void> whichScreenToNavigate() async {
    final SharedPref _sharedPref = SharedPref();
    token = await _sharedPref.readString('apiToken');
    print(token);
    Timer(Duration(seconds: 3), () {
      token == null 
          ? Get.offNamed(LOGIN_PAGE)
          : Get.off(First());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: AliceColors.SPLASH_SCREEN_BACKGROUND,
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
