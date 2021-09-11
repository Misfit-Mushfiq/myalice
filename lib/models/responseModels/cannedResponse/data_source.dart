import 'project.dart';

class DataSource {
  int? id;
  int? admin;
  Project? project;
  String? title;
  String? text;
  bool? forTeam;

  DataSource({
    this.id,
    this.admin,
    this.project,
    this.title,
    this.text,
    this.forTeam,
  });

  factory DataSource.fromJson(Map<String, dynamic> json) => DataSource(
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
}
