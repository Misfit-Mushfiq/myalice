import 'nlp_info.dart';
import 'persistent_menu.dart';
import 'project.dart';

class ChannelDataSource {
  int? id;
  Project? project;
  String? primaryId;
  dynamic primaryColor;
  String? accessToken;
  String? title;
  String? description;
  String? name;
  String? type;
  String? username;
  String? url;
  String? avatar;
  dynamic cover;
  String? nlpEngine;
  NlpInfo? nlpInfo;
  double? nlpConfidence;
  bool? isConnected;
  List<dynamic>? whitelistedDomains;
  List<PersistentMenu>? persistentMenu;
  String? secondaryReceiverId;
  int? monthlyActiveUsers;
  int? ticketCount;
  int? customerCount;
  String? mainType;
  bool? isEcommercePluginChannel;
  bool? isArchived;
  String? secondaryId;
  List<dynamic>? iceBreaker;

  ChannelDataSource({
    this.id,
    this.project,
    this.primaryId,
    this.primaryColor,
    this.accessToken,
    this.title,
    this.description,
    this.name,
    this.type,
    this.username,
    this.url,
    this.avatar,
    this.cover,
    this.nlpEngine,
    this.nlpInfo,
    this.nlpConfidence,
    this.isConnected,
    this.whitelistedDomains,
    this.persistentMenu,
    this.secondaryReceiverId,
    this.monthlyActiveUsers,
    this.ticketCount,
    this.customerCount,
    this.mainType,
    this.isEcommercePluginChannel,
    this.isArchived,
    this.secondaryId,
    this.iceBreaker,
  });

  factory ChannelDataSource.fromJson(Map<String, dynamic> json) =>
      ChannelDataSource(
        id: json['id'] as int?,
        project: json['project'] == null
            ? null
            : Project.fromJson(json['project'] as Map<String, dynamic>),
        primaryId: json['primary_id'] as String?,
        primaryColor: json['primary_color'],
        accessToken: json['access_token'] as String?,
        title: json['title'] as String?,
        description: json['description'] as String?,
        name: json['name'] as String?,
        type: json['type'] as String?,
        username: json['username'] as String?,
        url: json['url'] as String?,
        avatar: json['avatar'] as String?,
        cover: json['cover'],
        nlpEngine: json['nlp_engine'] as String?,
        nlpInfo: json['nlp_info'] == null
            ? null
            : NlpInfo.fromJson(json['nlp_info'] as Map<String, dynamic>),
        nlpConfidence: json['nlp_confidence'] as double?,
        isConnected: json['is_connected'] as bool?,
        whitelistedDomains: json['whitelisted_domains'] as List<dynamic>?,
        persistentMenu: (json['persistent_menu'] as List<dynamic>?)
            ?.map((e) => PersistentMenu.fromJson(e as Map<String, dynamic>))
            .toList(),
        secondaryReceiverId: json['secondary_receiver_id'] as String?,
        monthlyActiveUsers: json['monthly_active_users'] as int?,
        ticketCount: json['ticket_count'] as int?,
        customerCount: json['customer_count'] as int?,
        mainType: json['main_type'] as String?,
        isEcommercePluginChannel: json['is_ecommerce_plugin_channel'] as bool?,
        isArchived: json['is_archived'] as bool?,
        secondaryId: json['secondary_id'] as String?,
        iceBreaker: json['ice_breaker'] as List<dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'project': project?.toJson(),
        'primary_id': primaryId,
        'primary_color': primaryColor,
        'access_token': accessToken,
        'title': title,
        'description': description,
        'name': name,
        'type': type,
        'username': username,
        'url': url,
        'avatar': avatar,
        'cover': cover,
        'nlp_engine': nlpEngine,
        'nlp_info': nlpInfo?.toJson(),
        'nlp_confidence': nlpConfidence,
        'is_connected': isConnected,
        'whitelisted_domains': whitelistedDomains,
        'persistent_menu': persistentMenu?.map((e) => e.toJson()).toList(),
        'secondary_receiver_id': secondaryReceiverId,
        'monthly_active_users': monthlyActiveUsers,
        'ticket_count': ticketCount,
        'customer_count': customerCount,
        'main_type': mainType,
        'is_ecommerce_plugin_channel': isEcommercePluginChannel,
        'is_archived': isArchived,
        'secondary_id': secondaryId,
        'ice_breaker': iceBreaker,
      };
}
