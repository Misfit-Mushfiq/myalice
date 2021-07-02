import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myalice/screens/loginScreen.dart';
import 'package:myalice/screens/splashScreen.dart';
import 'package:myalice/utils/constant_strings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: ThemeData(
          textTheme: GoogleFonts.interTextTheme(
        Theme.of(context).textTheme,
      )),
      getPages: [
        GetPage(name: LOGIN_PAGE, page: ()=> LoginScreen())
      ],
    );
  }
}