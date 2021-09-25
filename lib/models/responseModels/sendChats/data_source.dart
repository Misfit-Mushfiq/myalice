import 'package:myalice/models/responseModels/sendChats/data.dart';

import 'admin_info.dart';

class SendDataSource {
  dynamic id;
  String? type;
  String? source;
  String? platformType;
  int? platformId;
  int? customerId;
  int? projectId;
  Data? data;
  String? conversationId;
  int? timestamp;
  int? adminId;
  AdminInfo? adminInfo;
  dynamic success;
  String? pusherKey;

  SendDataSource({
    this.id,
    this.type,
    this.source,
    this.platformType,
    this.platformId,
    this.customerId,
    this.projectId,
    this.data,
    this.conversationId,
    this.timestamp,
    this.adminId,
    this.adminInfo,
    this.success,
    this.pusherKey,
  });

  factory SendDataSource.fromJson(Map<String, dynamic> json) => SendDataSource(
        id: json['_id'],
        type: json['type'] as String?,
        source: json['source'] as String?,
        platformType: json['platform_type'] as String?,
        platformId: json['platform_id'] as int?,
        customerId: json['customer_id'] as int?,
        projectId: json['project_id'] as int?,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
        conversationId: json['conversation_id'] as String?,
        timestamp: json['timestamp'] as int?,
        adminId: json['admin_id'] as int?,
        adminInfo: json['admin_info'] == null
            ? null
            : AdminInfo.fromJson(json['admin_info'] as Map<String, dynamic>),
        success: json['success'],
        pusherKey: json['pusher_key'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'type': type,
        'source': source,
        'platform_type': platformType,
        'platform_id': platformId,
        'customer_id': customerId,
        'project_id': projectId,
        'data': data?.toJson(),
        'conversation_id': conversationId,
        'timestamp': timestamp,
        'admin_id': adminId,
        'admin_info': adminInfo?.toJson(),
        'success': success,
        'pusher_key': pusherKey,
      };
}
