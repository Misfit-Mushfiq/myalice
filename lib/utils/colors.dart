import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AliceColors {
  static const SPLASH_SCREEN_BACKGROUND = const Color(0xFF1F2937);
  static const ALICE_GREEN = const Color(0xFF04B25F);
  static const CHAT_RECEIVER = const Color(0xFFF3F4F6);
  static const CHAT_SENDER = const Color(0xFF04B25F);
  static const ALICE_GREY = const Color(0xFFF3F4F6);
  static const ALICE_BLUE = const Color(0xFF0078CF);
  static const ALICE_VIBER = const Color(0xFF7360F2);
  static const ALICE_SELECTED_CHANNEL = const Color(0xFFCDF0DF);
  static const ALICE_ORANGE = const Color(0xFFF59E0B);
  static const ALICE_ORANGE_LIGHT = const Color(0xFFFFFBEB);
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
    case "facebook_feed":
      return AliceColors.ALICE_BLUE;
    case "telegram_messenger":
      return AliceColors.ALICE_BLUE;
    case "webchat":
      return Colors.redAccent;
    case "instagram_messenger":
      return Colors.redAccent;
    default:
      return AliceColors.ALICE_BLUE;
  }
}
