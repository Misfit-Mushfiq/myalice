import 'dart:convert';

import 'admin.dart';
import 'role.dart';

class AssignedAgentsDataSource {
  int? id;
  Admin? admin;
  Role? role;
  List<dynamic>? groups;
  bool? ticketSoundOn;
  bool? messageSoundOn;
  bool? browserNotificationOn;
  bool? isDeletable;

  AssignedAgentsDataSource({
    this.id,
    this.admin,
    this.role,
    this.groups,
    this.ticketSoundOn,
    this.messageSoundOn,
    this.browserNotificationOn,
    this.isDeletable,
  });

  factory AssignedAgentsDataSource.fromJson(Map<String, dynamic> json) =>
      AssignedAgentsDataSource(
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
          AssignedAgentsDataSource assignedAgentsDataSource) =>
      {
        'id': assignedAgentsDataSource.id,
        'admin': assignedAgentsDataSource.admin?.toJson(),
        'role': assignedAgentsDataSource.role?.toJson(),
        'groups': assignedAgentsDataSource.groups,
        'ticket_sound_on': assignedAgentsDataSource.ticketSoundOn,
        'message_sound_on': assignedAgentsDataSource.messageSoundOn,
        'browser_notification_on':
            assignedAgentsDataSource.browserNotificationOn,
        'is_deletable': assignedAgentsDataSource.isDeletable,
      };

 static String encode(List<AssignedAgentsDataSource> assignedAgentsDataSourceList) =>
      json.encode(
        assignedAgentsDataSourceList
            .map<Map<String, dynamic>>((assignedAgentsDataSource) =>
                AssignedAgentsDataSource.toMap(assignedAgentsDataSource))
            .toList(),
      );

 static List<AssignedAgentsDataSource> decode(String assignedAgentsDataSource) =>
      (json.decode(assignedAgentsDataSource) as List<dynamic>)
          .map<AssignedAgentsDataSource>(
              (item) => AssignedAgentsDataSource.fromJson(item))
          .toList();
}
