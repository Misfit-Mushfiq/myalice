class Platform {
  int? id;
  String? primaryId;
  String? name;
  String? type;

  Platform({this.id, this.primaryId, this.name, this.type});

  factory Platform.fromJson(Map<String, dynamic> json) => Platform(
        id: json['id'] as int?,
        primaryId: json['primary_id'] as String?,
        name: json['name'] as String?,
        type: json['type'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'primary_id': primaryId,
        'name': name,
        'type': type,
      };
}
