import 'data_source.dart';

class CreateTagsResponse {
  bool? success;
  CreateTagsDataSource? dataSource;

  CreateTagsResponse({this.success, this.dataSource});

  factory CreateTagsResponse.fromJson(Map<String, dynamic> json) =>
      CreateTagsResponse(
        success: json['success'] as bool?,
        dataSource: json['dataSource'] == null
            ? null
            : CreateTagsDataSource.fromJson(json['dataSource'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'dataSource': dataSource?.toJson(),
      };
}
