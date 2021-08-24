import 'data_source.dart';

class TicketsResponse {
  bool? success;
  List<DataSource>? dataSource;
  int? total;

  TicketsResponse({this.success, this.dataSource, this.total});

  factory TicketsResponse.fromJson(Map<String, dynamic> json) =>
      TicketsResponse(
        success: json['success'] ,
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
