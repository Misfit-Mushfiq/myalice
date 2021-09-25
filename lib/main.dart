// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myalice/controllers/apiControllers/databinging.dart';
import 'package:myalice/models/responseModels/customerOrder/customer_order_history.dart';
import 'package:myalice/screens/chatDetails/chatDetails.dart';
import 'package:myalice/screens/customerProfile/customerInfo.dart';
import 'package:myalice/screens/customerProfile/customerProfile.dart';
import 'package:myalice/screens/customerProfile/customerSummary.dart';
import 'package:myalice/screens/customerProfile/editCustomerInfo.dart';
import 'package:myalice/screens/customerProfile/orderHistory.dart';
import 'package:myalice/screens/customerProfile/productInteraction.dart';
import 'package:myalice/screens/forgotPassword.dart';
import 'package:myalice/screens/inboxScreen/inboxScreen.dart';
import 'package:myalice/screens/loginScreen.dart';
import 'package:myalice/screens/signUpScreen.dart';
import 'package:myalice/screens/splashScreen.dart';
import 'package:myalice/screens/agentProfile/agentProfile.dart';
import 'package:myalice/utils/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DataBinding().dependencies();
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: Get.key,
      home: SplashScreen(),
      enableLog: true,
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
      ),
      getPages: [
        GetPage(name: LOGIN_PAGE, page: () => LoginScreen()),
        GetPage(name: CHAT_DETAILS_PAGE, page: () => ChatDetails()),
        GetPage(name: INBOX_PAGE, page: () => Inbox(), binding: DataBinding()),
        GetPage(name: SIGNUP_PAGE, page: () => SignUpScreen()),
        GetPage(name: USER_PROFILE_PAGE, page: () => AgentProfile()),
        GetPage(name: CUSTOMER_PROFILE_PAGE, page: () => CustomerProfile()),
        GetPage(name: CUSTOMER_INFO_PAGE, page: () => CustomerInfo()),
        GetPage(name: CUSTOMER_INFO_EDIT, page: () => EditCustomerInfo()),
        GetPage(name: CUSTOMER_ORDER, page: () => OrderHistory()),
        GetPage(name: CUSTOMER_SUMMARY, page: () => CustomerSummaryScreen()),
        GetPage(
            name: CUSTOMER_PRODUCT_INTERACTION,
            page: () => ProductInteractionScreen()),
            GetPage(
            name: FORGOT_PASSWORD,
            page: () => ForgotPassword()), 
      ],
    );
  }
}
