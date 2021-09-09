class TagModel {
  String? action;
  String? name;
  int? id;

  TagModel({this.action, this.name, this.id});

  factory TagModel.fromJson(Map<String, dynamic> json) => TagModel(
        action: json['action'] as String?,
        name: json['name'] as String?,
        id: json['id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'action': action,
        'name': name,
        'id': id,
      };
}
