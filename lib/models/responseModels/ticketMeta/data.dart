import 'platform.dart';

class MetaData {
  int? id;
  Platform? platform;
  List<dynamic>? tags;
  bool? botEnabled;
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
  String? createdAt;
  String? lastMessageText;
  String? lastMessageTime;
  bool? isLinkedWithEcommerceAccount;

  MetaData({
    this.id,
    this.platform,
    this.tags,
    this.botEnabled,
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
    this.createdAt,
    this.lastMessageText,
    this.lastMessageTime,
    this.isLinkedWithEcommerceAccount,
  });

  factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
        id: json['id'] as int?,
        platform: json['platform'] == null
            ? null
            : Platform.fromJson(json['platform'] as Map<String, dynamic>),
        tags: json['tags'] as List<dynamic>?,
        botEnabled: json['bot_enabled'] as bool?,
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
        createdAt: json['created_at'] as String?,
        lastMessageText: json['last_message_text'] as String?,
        lastMessageTime: json['last_message_time'] as String?,
        isLinkedWithEcommerceAccount:
            json['is_linked_with_ecommerce_account'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'platform': platform?.toJson(),
        'tags': tags,
        'bot_enabled': botEnabled,
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
        'created_at': createdAt,
        'last_message_text': lastMessageText,
        'last_message_time': lastMessageTime,
        'is_linked_with_ecommerce_account': isLinkedWithEcommerceAccount,
      };
}
