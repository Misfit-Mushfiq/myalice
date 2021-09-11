class AttachedData {
  String? text;
  String? subType;
  List<dynamic> urls;

  AttachedData({this.subType, required this.urls, this.text});

  factory AttachedData.fromJson(Map<String, dynamic> json) => AttachedData(
        subType: json['sub_type'] as String?,
        text: json['text'] as String?,
        urls: json['urls'] as List<dynamic>,
      );

  Map<String, dynamic> toJson() =>
      {'sub_type': subType, 'urls': urls, "text": text};
}
