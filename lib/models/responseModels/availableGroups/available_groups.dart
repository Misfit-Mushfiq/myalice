import 'data_source.dart';

class AvailableGroups {
  bool? success;
  List<AvailableGroupsDataSource>? dataSource;

  AvailableGroups({this.success, this.dataSource});

  factory AvailableGroups.fromJson(Map<String, dynamic> json) =>
      AvailableGroups(
        success: json['success'] as bool?,
        dataSource: (json['dataSource'] as List<dynamic>?)
            ?.map((e) => AvailableGroupsDataSource.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'dataSource': dataSource?.map((e) => e.toJson()).toList(),
      };
}
