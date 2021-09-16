// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myalice/controllers/apiControllers/databinging.dart';
import 'package:myalice/controllers/apiControllers/inboxController.dart';
import 'package:myalice/screens/chatDetails/chatDetails.dart';
import 'package:myalice/screens/customerInfo.dart';
import 'package:myalice/screens/customerProfile.dart';
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
      routingCallback: (route) {
        if (route.current == INBOX_PAGE) {
          InboxController inboxController = Get.put(InboxController());
          inboxController.onInit();
          return;
        }
      },
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
      ],
    );
  }
}

class Router {
  static GetPageRoute<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return GetPageRoute(page: () => SplashScreen(), settings: settings);
      case LOGIN_PAGE:
        return GetPageRoute(
            routeName: LOGIN_PAGE,
            page: () => LoginScreen(),
            settings: settings);
      case CHAT_DETAILS_PAGE:
        return GetPageRoute(
            routeName: CHAT_DETAILS_PAGE,
            page: () => ChatDetails(),
            settings: settings);
      case INBOX_PAGE:
        return GetPageRoute(
            routeName: INBOX_PAGE,
            page: () => Inbox(),
            binding: DataBinding(),
            settings: settings);
      case USER_PROFILE_PAGE:
        return GetPageRoute(
            routeName: USER_PROFILE_PAGE,
            page: () => AgentProfile(),
            settings: settings);
      case CUSTOMER_PROFILE_PAGE:
        return GetPageRoute(
            routeName: CUSTOMER_PROFILE_PAGE,
            page: () => CustomerProfile(),
            settings: settings);
      case CUSTOMER_INFO_PAGE:
        return GetPageRoute(
            routeName: CUSTOMER_INFO_PAGE,
            page: () => CustomerInfo(),
            settings: settings);
      default:
        return GetPageRoute(
            routeName: SIGNUP_PAGE,
            page: () => SignUpScreen(),
            settings: settings);
    }
  }
}

class MiddleWare {
  static observer(Routing routing) {
    /// You can listen in addition to the routes, the snackbars, dialogs and bottomsheets on each screen.
    ///If you need to enter any of these 3 events directly here,
    ///you must specify that the event is != Than you are trying to do.
    if (routing.current == '/second' && !routing.isSnackbar) {
      Get.snackbar("Hi", "You are on second route");
    } else if (routing.current == '/third') {
      print('last route called');
    }
  }
}
