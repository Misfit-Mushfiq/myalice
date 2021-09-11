import 'data_source.dart';

class AvailableAgents {
  bool? success;
  List<AvailableAgentsDataSource>? dataSource;

  AvailableAgents({this.success, this.dataSource});

  factory AvailableAgents.fromJson(Map<String, dynamic> json) => AvailableAgents(
        success: json['success'] as bool?,
        dataSource: (json['dataSource'] as List<dynamic>?)
            ?.map((e) =>
                AvailableAgentsDataSource.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'dataSource': dataSource?.map((e) => e.toJson()).toList(),
      };
}
