import 'data_source.dart';

class CannedResponse {
  bool? success;
  List<DataSource>? dataSource;
  int? total;

  CannedResponse({this.success, this.dataSource, this.total});

  factory CannedResponse.fromJson(Map<String, dynamic> json) => CannedResponse(
        success: json['success'] as bool?,
        dataSource: (json['dataSource'] as List<dynamic>?)
            ?.map((e) => DataSource.fromJson(e as Map<String, dynamic>))
            .toList(),
        total: json['total'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'dataSource': dataSource?.map((e) => e.toJson()).toList(),
        'total': total,
      };
}
