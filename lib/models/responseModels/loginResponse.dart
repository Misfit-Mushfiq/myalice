class LoginResponse {
  bool? success;
  String? refresh;
  String? access;

  LoginResponse({this.success, this.refresh, this.access});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    refresh = json['refresh'];
    access = json['access'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['refresh'] = this.refresh;
    data['access'] = this.access;
    return data;
  }
}