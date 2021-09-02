import 'data_source.dart';

class Projects {
  bool? success;
  List<ChannelDataSource>? dataSource;

  Projects({this.success, this.dataSource});

  factory Projects.fromJson(Map<String, dynamic> json) => Projects(
        success: json['success'] as bool?,
        dataSource: (json['dataSource'] as List<dynamic>?)
            ?.map((e) => ChannelDataSource.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'dataSource': dataSource?.map((e) => e.toJson()).toList(),
      };
}
