import 'permission.dart';

class Role {
  int? id;
  String? name;
  List<Permission>? permissions;

  Role({this.id, this.name, this.permissions});

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json['id'] as int?,
        name: json['name'] as String?,
        permissions: (json['permissions'] as List<dynamic>?)
            ?.map((e) => Permission.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'permissions': permissions?.map((e) => e.toJson()).toList(),
      };
}
