import 'dart:convert';

import 'admin.dart';
import 'role.dart';

class AvailableAgentsDataSource {
  int? id;
  Admin? admin;
  Role? role;
  List<dynamic>? groups;
  bool? ticketSoundOn;
  bool? messageSoundOn;
  bool? browserNotificationOn;
  bool? isDeletable;

  AvailableAgentsDataSource({
    this.id,
    this.admin,
    this.role,
    this.groups,
    this.ticketSoundOn,
    this.messageSoundOn,
    this.browserNotificationOn,
    this.isDeletable,
  });

  factory AvailableAgentsDataSource.fromJson(Map<String, dynamic> json) =>
      AvailableAgentsDataSource(
        id: json['id'] as int?,
        admin: json['admin'] == null
            ? null
            : Admin.fromJson(json['admin'] as Map<String, dynamic>),
        role: json['role'] == null
            ? null
            : Role.fromJson(json['role'] as Map<String, dynamic>),
        groups: json['groups'] as List<dynamic>?,
        ticketSoundOn: json['ticket_sound_on'] as bool?,
        messageSoundOn: json['message_sound_on'] as bool?,
        browserNotificationOn: json['browser_notification_on'] as bool?,
        isDeletable: json['is_deletable'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'admin': admin?.toJson(),
        'role': role?.toJson(),
        'groups': groups,
        'ticket_sound_on': ticketSoundOn,
        'message_sound_on': messageSoundOn,
        'browser_notification_on': browserNotificationOn,
        'is_deletable': isDeletable,
      };

  static Map<String, dynamic> toMap(
          AvailableAgentsDataSource availableAgentsDataSource) =>
      {
        'id': availableAgentsDataSource.id,
        'admin': availableAgentsDataSource.admin?.toJson(),
        'role': availableAgentsDataSource.role?.toJson(),
        'groups': availableAgentsDataSource.groups,
        'ticket_sound_on': availableAgentsDataSource.ticketSoundOn,
        'message_sound_on': availableAgentsDataSource.messageSoundOn,
        'browser_notification_on':
            availableAgentsDataSource.browserNotificationOn,
        'is_deletable': availableAgentsDataSource.isDeletable,
      };

  static String encode(
          List<AvailableAgentsDataSource> availableAgentsDataSourceList) =>
      json.encode(
        availableAgentsDataSourceList
            .map<Map<String, dynamic>>((availableAgentsDataSource) =>
                AvailableAgentsDataSource.toMap(availableAgentsDataSource))
            .toList(),
      );

  static List<AvailableAgentsDataSource> decode(
      String availableAgentsDataSource) {
    return availableAgentsDataSource != null
        ? (json.decode(availableAgentsDataSource) ?? [])
            .map<AvailableAgentsDataSource>(
                (item) => AvailableAgentsDataSource.fromJson(item))
            .toList()
        : [];
  }
}
