class NlpInfo {
  String? token;
  String? appId;

  NlpInfo({this.token, this.appId});

  factory NlpInfo.fromJson(Map<String, dynamic> json) => NlpInfo(
        token: json['token'] as String?,
        appId: json['app_id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'token': token,
        'app_id': appId,
      };
}
