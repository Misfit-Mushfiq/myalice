import 'data_source.dart';

class Tags {
  bool? success;
  List<TagsDataSource>? dataSource;

  Tags({this.success, this.dataSource});

  factory Tags.fromJson(Map<String, dynamic> json) => Tags(
        success: json['success'] as bool?,
        dataSource: (json['dataSource'] as List<dynamic>?)
            ?.map((e) => TagsDataSource.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'dataSource': dataSource?.map((e) => e.toJson()).toList(),
      };
}
