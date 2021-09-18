import 'data_source.dart';

class CustomerOrderHistory {
  bool? success;
  List<OrderDataSource>? dataSource;

  CustomerOrderHistory({this.success, this.dataSource});

  factory CustomerOrderHistory.fromJson(Map<String, dynamic> json) =>
      CustomerOrderHistory(
        success: json['success'] as bool?,
        dataSource: (json['dataSource'] as List<dynamic>?)
            ?.map((e) => OrderDataSource.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'dataSource': dataSource?.map((e) => e.toJson()).toList(),
      };
}
