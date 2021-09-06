import 'data_source.dart';

class AssignedAgents {
  bool? success;
  List<AssignedAgentsDataSource>? dataSource;

  AssignedAgents({this.success, this.dataSource});

  factory AssignedAgents.fromJson(Map<String, dynamic> json) => AssignedAgents(
        success: json['success'] as bool?,
        dataSource: (json['dataSource'] as List<dynamic>?)
            ?.map((e) =>
                AssignedAgentsDataSource.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'dataSource': dataSource?.map((e) => e.toJson()).toList(),
      };
}
