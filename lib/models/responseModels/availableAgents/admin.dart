class Admin {
  int? id;
  String? email;
  String? avatar;
  String? fullName;
  String? status;
  String? lastOnlineTime;

  Admin({
    this.id,
    this.email,
    this.avatar,
    this.fullName,
    this.status,
    this.lastOnlineTime,
  });

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
        id: json['id'] as int?,
        email: json['email'] as String?,
        avatar: json['avatar'] ?? "" as String?,
        fullName: json['full_name'] as String?,
        status: json['status'] as String?,
        lastOnlineTime: json['last_online_time'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'avatar': avatar,
        'full_name': fullName,
        'status': status,
        'last_online_time': lastOnlineTime,
      };
}
