import 'data_source.dart';

class CustomerSummary {
  bool? success;
  SummaryDataSource? dataSource;

  CustomerSummary({this.success, this.dataSource});

  factory CustomerSummary.fromJson(Map<String, dynamic> json) =>
      CustomerSummary(
        success: json['success'] as bool?,
        dataSource: json['dataSource'] == null
            ? null
            : SummaryDataSource.fromJson(
                json['dataSource'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'dataSource': dataSource?.toJson(),
      };
}
