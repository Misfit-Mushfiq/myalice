class CreateTagsProject {
  int? id;
  String? name;

  CreateTagsProject({this.id, this.name});

  factory CreateTagsProject.fromJson(Map<String, dynamic> json) => CreateTagsProject(
        id: json['id'] as int?,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
