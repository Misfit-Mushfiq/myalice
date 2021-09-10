class ImageDataSource {
  int? id;
  String? s3Url;

  ImageDataSource({this.id, this.s3Url});

  factory ImageDataSource.fromJson(Map<String, dynamic> json) =>
      ImageDataSource(
        id: json['id'] as int?,
        s3Url: json['s3_url'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        's3_url': s3Url,
      };
}
