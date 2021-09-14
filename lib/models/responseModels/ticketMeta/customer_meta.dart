import 'data.dart';

class CustomerMeta {
  bool? success;
  MetaData? data;

  CustomerMeta({this.success, this.data});

  factory CustomerMeta.fromJson(Map<String, dynamic> json) => CustomerMeta(
        success: json['success'] as bool?,
        data: json['data'] == null
            ? null
            : MetaData.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'data': data?.toJson(),
      };
}
