import 'project.dart';

class CreateTagsDataSource {
  int? id;
  CreateTagsProject? project;
  String? name;

  CreateTagsDataSource({this.id, this.project, this.name});

  factory CreateTagsDataSource.fromJson(Map<String, dynamic> json) => CreateTagsDataSource(
        id: json['id'] as int?,
        project: json['project'] == null
            ? null
            : CreateTagsProject.fromJson(json['project'] as Map<String, dynamic>),
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'project': project?.toJson(),
        'name': name,
      };
}
