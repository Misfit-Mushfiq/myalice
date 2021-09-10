import 'data_source.dart';

class ImageUpload {
  bool? success;
  ImageDataSource? dataSource;

  ImageUpload({this.success, this.dataSource});

  factory ImageUpload.fromJson(Map<String, dynamic> json) => ImageUpload(
        success: json['success'] as bool?,
        dataSource: json['dataSource'] == null
            ? null
            : ImageDataSource.fromJson(json['dataSource'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'dataSource': dataSource?.toJson(),
      };
}
