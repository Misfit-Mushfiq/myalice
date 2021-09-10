import 'data_source.dart';

class SendData {
  bool? success;
  SendDataSource? dataSource;

  SendData({this.success, this.dataSource});

  factory SendData.fromJson(Map<String, dynamic> json) => SendData(
        success: json['success'] as bool?,
        dataSource: json['dataSource'] == null
            ? null
            : SendDataSource.fromJson(json['dataSource'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'dataSource': dataSource?.toJson(),
      };
}
