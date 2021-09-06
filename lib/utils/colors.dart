import 'package:flutter/cupertino.dart';

class AliceColors {
  static const SPLASH_SCREEN_BACKGROUND = const Color(0xFF1F2937);
  static const ALICE_GREEN = const Color(0xFF04B25F);
  static const CHAT_RECEIVER = const Color(0xFFF3F4F6);
  static const CHAT_SENDER = const Color(0xFF04B25F);
  static const ALICE_GREY = const Color(0xFFF3F4F6);
  static const ALICE_BLUE = const Color(0xFF0078CF);
  static const ALICE_VIBER = const Color(0xFF7360F2);
  static const ALICE_SELECTED_CHANNEL = const Color(0xFFCDF0DF);
}

Color platformColor(String name) {
  switch (name) {
    case "whatsapp_messenger":
      return AliceColors.ALICE_GREEN;
    case "facebook_messenger":
      return AliceColors.ALICE_BLUE;
    case "viber_messenger":
      return AliceColors.ALICE_VIBER;
    case "line_messenger":
      return AliceColors.ALICE_GREEN;
    case "facebook":
      return AliceColors.ALICE_GREEN;
    case "telegram_messenger":
      return AliceColors.ALICE_BLUE;
    default:
      return AliceColors.ALICE_BLUE;
  }
}
