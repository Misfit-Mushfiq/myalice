import 'dart:convert';

import 'project.dart';

class CannedDataSource {
  int? id;
  int? admin;
  Project? project;
  String? title;
  String? text;
  bool? forTeam;

  CannedDataSource({
    this.id,
    this.admin,
    this.project,
    this.title,
    this.text,
    this.forTeam,
  });

  factory CannedDataSource.fromJson(Map<String, dynamic> json) =>
      CannedDataSource(
        id: json['id'] as int?,
        admin: json['admin'] as int?,
        project: json['project'] == null
            ? null
            : Project.fromJson(json['project'] as Map<String, dynamic>),
        title: json['title'] as String?,
        text: json['text'] as String?,
        forTeam: json['for_team'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'admin': admin,
        'project': project?.toJson(),
        'title': title,
        'text': text,
        'for_team': forTeam,
      };

  static Map<String, dynamic> toMap(CannedDataSource tags) => {
        'id': tags.id,
        'admin': tags.admin,
        'project': tags.project?.toJson(),
        'title': tags.title,
        'text': tags.text,
        'for_team': tags.forTeam,
      };

  static String encode(List<CannedDataSource> tagsList) => json.encode(
        tagsList
            .map<Map<String, dynamic>>((tags) => CannedDataSource.toMap(tags))
            .toList(),
      );

  static List<CannedDataSource> decode(String tags) {
    return tags != null
        ? (json.decode(tags) ?? [])
            .map<CannedDataSource>((item) => CannedDataSource.fromJson(item))
            .toList()
        : [];
  }
}
