import 'package:myalice/models/responseModels/tags/data_source.dart';
import 'package:myalice/models/responseModels/ticketsResponseModels/agent.dart';

import 'customer.dart';

class DataSource {
  int? id;
  String? description;
  int? priority;
  String? priorityStr;
  String? conversationId;
  String? createdAt;
  bool? isReplied;
  Customer? customer;
  List<AssignedAgents>? agents;
  List<TagsDataSource>? tags;
  List<dynamic>? groups;
  bool? isResolved;
  dynamic resolvedAt;
  dynamic resolvedBy;
  bool? isLocked;
  dynamic lockedAt;
  dynamic lockedBy;

  DataSource({
    this.id,
    this.description,
    this.priority,
    this.priorityStr,
    this.conversationId,
    this.createdAt,
    this.isReplied,
    this.customer,
    this.agents,
    this.tags,
    this.groups,
    this.isResolved,
    this.resolvedAt,
    this.resolvedBy,
    this.isLocked,
    this.lockedAt,
    this.lockedBy,
  });

  factory DataSource.fromJson(Map<String, dynamic> json) => DataSource(
        id: json['id'] as int?,
        description: json['description'] as String?,
        priority: json['priority'] as int?,
        priorityStr: json['priority_str'] as String?,
        conversationId: json['conversation_id'] as String?,
        createdAt: json['created_at'] as String?,
        isReplied: json['is_replied'] as bool?,
        customer: json['customer'] == null
            ? null
            : Customer.fromJson(json['customer'] as Map<String, dynamic>),
        agents: (json['agents'] as List<dynamic>?)
            ?.map((e) => AssignedAgents.fromJson(e as Map<String, dynamic>))
            .toList(),
         tags: (json['tags'] as List<dynamic>?)
            ?.map((e) => TagsDataSource.fromJson(e as Map<String, dynamic>))
            .toList(),
        groups: json['groups'] as List<dynamic>?,
        isResolved: json['is_resolved'] as bool?,
        resolvedAt: json['resolved_at'],
        resolvedBy: json['resolved_by'],
        isLocked: json['is_locked'] as bool?,
        lockedAt: json['locked_at'],
        lockedBy: json['locked_by'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'priority': priority,
        'priority_str': priorityStr,
        'conversation_id': conversationId,
        'created_at': createdAt,
        'is_replied': isReplied,
        'customer': customer?.toJson(),
        'tags': tags,
        'groups': groups,
        'is_resolved': isResolved,
        'resolved_at': resolvedAt,
        'resolved_by': resolvedBy,
        'is_locked': isLocked,
        'locked_at': lockedAt,
        'locked_by': lockedBy,
        'agents': agents?.map((e) => e.toJson()).toList(),
      };
}
