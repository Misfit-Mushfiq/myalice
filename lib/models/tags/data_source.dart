class TagsDataSource {
  int? id;
  String? name;

  TagsDataSource({this.id, this.name});

  factory TagsDataSource.fromJson(Map<String, dynamic> json) => TagsDataSource(
        id: json['id'] as int?,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
