import 'dart:convert';

import 'meta.dart';
import 'platform.dart';

class Customer {
  int? id;
  Platform? platform;
  String? primaryId;
  dynamic avatar;
  String? firstName;
  String? lastName;
  String? fullName;
  String? gender;
  dynamic timezone;
  String? locale;
  String? language;
  String? phone;
  dynamic email;
  Meta? meta;
  String? createdAt;
  String? lastMessageText;
  String? lastMessageTime;

  Customer({
    this.id,
    this.platform,
    this.primaryId,
    this.avatar,
    this.firstName,
    this.lastName,
    this.fullName,
    this.gender,
    this.timezone,
    this.locale,
    this.language,
    this.phone,
    this.email,
    this.meta,
    this.createdAt,
    this.lastMessageText,
    this.lastMessageTime,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json['id'] as int?,
        platform: json['platform'] == null
            ? null
            : Platform.fromJson(json['platform'] as Map<String, dynamic>),
        primaryId: json['primary_id'] as String?,
        avatar: json['avatar'],
        firstName: json['first_name'] as String?,
        lastName: json['last_name'] as String?,
        fullName: json['full_name'] as String?,
        gender: json['gender'] as String?,
        timezone: json['timezone'],
        locale: json['locale'] as String?,
        language: json['language'] as String?,
        phone: json['phone'] as String?,
        email: json['email'],
        meta: json['meta'] == null
            ? null
            : Meta.fromJson(json['meta'] as Map<String, dynamic>),
        createdAt: json['created_at'] as String?,
        lastMessageText: json['last_message_text'] as String?,
        lastMessageTime: json['last_message_time'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'platform': platform?.toJson(),
        'primary_id': primaryId,
        'avatar': avatar,
        'first_name': firstName,
        'last_name': lastName,
        'full_name': fullName,
        'gender': gender,
        'timezone': timezone,
        'locale': locale,
        'language': language,
        'phone': phone,
        'email': email,
        'meta': meta?.toJson(),
        'created_at': createdAt,
        'last_message_text': lastMessageText,
        'last_message_time': lastMessageTime,
      };
}
