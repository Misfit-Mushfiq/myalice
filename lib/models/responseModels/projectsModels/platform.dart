class Platform {
  int? id;
  String? primaryId;
  dynamic primaryColor;
  String? accessToken;
  String? title;
  String? name;
  String? type;
  String? username;
  String? url;
  dynamic avatar;
  dynamic cover;
  bool? isConnected;
  List<dynamic>? persistentMenu;
  String? secondaryReceiverId;
  int? monthlyActiveUsers;
  String? mainType;
  List<dynamic>? iceBreaker;

  Platform({
    this.id,
    this.primaryId,
    this.primaryColor,
    this.accessToken,
    this.title,
    this.name,
    this.type,
    this.username,
    this.url,
    this.avatar,
    this.cover,
    this.isConnected,
    this.persistentMenu,
    this.secondaryReceiverId,
    this.monthlyActiveUsers,
    this.mainType,
    this.iceBreaker,
  });

  factory Platform.fromJson(Map<String, dynamic> json) => Platform(
        id: json['id'] as int?,
        primaryId: json['primary_id'] as String?,
        primaryColor: json['primary_color'],
        accessToken: json['access_token'] as String?,
        title: json['title'] as String?,
        name: json['name'] as String?,
        type: json['type'] as String?,
        username: json['username'] as String?,
        url: json['url'] as String?,
        avatar: json['avatar'],
        cover: json['cover'],
        isConnected: json['is_connected'] as bool?,
        persistentMenu: json['persistent_menu'] as List<dynamic>?,
        secondaryReceiverId: json['secondary_receiver_id'] as String?,
        monthlyActiveUsers: json['monthly_active_users'] as int?,
        mainType: json['main_type'] as String?,
        iceBreaker: json['ice_breaker'] as List<dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'primary_id': primaryId,
        'primary_color': primaryColor,
        'access_token': accessToken,
        'title': title,
        'name': name,
        'type': type,
        'username': username,
        'url': url,
        'avatar': avatar,
        'cover': cover,
        'is_connected': isConnected,
        'persistent_menu': persistentMenu,
        'secondary_receiver_id': secondaryReceiverId,
        'monthly_active_users': monthlyActiveUsers,
        'main_type': mainType,
        'ice_breaker': iceBreaker,
      };
}
