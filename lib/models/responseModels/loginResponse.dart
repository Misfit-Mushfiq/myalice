class LoginResponse {
  bool? success;
  String? refresh;
  String? access;
  String? detail;

  LoginResponse({this.success, this.refresh, this.access, this.detail});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    refresh = json['refresh'];
    access = json['access'];
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['refresh'] = this.refresh;
    data['access'] = this.access;
    data['detail'] = this.detail;
    return data;
  }
}
