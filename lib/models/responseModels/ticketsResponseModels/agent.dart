class Agent {
  int? id;
  String? email;
  String? avatar;
  String? fullName;
  String? status;

  Agent({this.id, this.email, this.avatar, this.fullName, this.status});

  factory Agent.fromJson(Map<String, dynamic> json) => Agent(
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
