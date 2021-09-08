import 'dart:convert';

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
  static Map<String, dynamic> toMap(TagsDataSource tags) => {
        'id': tags.id,
        'name': tags.name,
      };

  static String encode(List<TagsDataSource> tagsList) => json.encode(
        tagsList
            .map<Map<String, dynamic>>((tags) => TagsDataSource.toMap(tags))
            .toList(),
      );

  static List<TagsDataSource> decode(String tags) {
    return tags != null
        ? (json.decode(tags) ?? [])
            .map<TagsDataSource>((item) => TagsDataSource.fromJson(item))
            .toList()
        : [];
  }
}
