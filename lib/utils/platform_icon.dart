 import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

IconData platformIcon(String name) {
    switch (name) {
      case "whatsapp_messenger":
        return FontAwesomeIcons.whatsapp;
      case "facebook_messenger":
        return FontAwesomeIcons.facebookMessenger;
      case "viber_messenger":
        return FontAwesomeIcons.viber;
      case "line_messenger":
        return FontAwesomeIcons.line;
      case "facebook":
        return FontAwesomeIcons.facebook;
      case "telegram_messenger":
        return FontAwesomeIcons.telegram;
      default:
        return FontAwesomeIcons.info;
    }
  }

  