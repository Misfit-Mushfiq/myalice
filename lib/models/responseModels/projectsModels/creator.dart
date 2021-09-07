class Creator {
  int? id;
  String? email;
  String? avatar;
  String? fullName;

  Creator({this.id, this.email, this.avatar, this.fullName});

  factory Creator.fromJson(Map<String, dynamic> json) => Creator(
        id: json['id'] as int?,
        email: json['email'] as String?,
        avatar: json['avatar'] as String?,
        fullName: json['full_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'avatar': avatar,
        'full_name': fullName,
      };
}
