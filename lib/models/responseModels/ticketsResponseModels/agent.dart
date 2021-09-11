class AssignedAgents {
  int? id;
  String? email;
  String? avatar;
  String? fullName;
  String? status;

  AssignedAgents({this.id, this.email, this.avatar, this.fullName, this.status});

  factory AssignedAgents.fromJson(Map<String, dynamic> json) => AssignedAgents(
        id: json['id'] as int?,
        email: json['email'] as String?,
        avatar: json['avatar'] as String?,
        fullName: json['full_name'] as String?,
        status: json['status'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'avatar': avatar,
        'full_name': fullName,
        'status': status,
      };
}
