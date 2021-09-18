import 'data_source.dart';

class ProductInteraction {
  bool? success;
  InteractionDataSource? dataSource;

  ProductInteraction({this.success, this.dataSource});

  factory ProductInteraction.fromJson(Map<String, dynamic> json) =>
      ProductInteraction(
        success: json['success'] as bool?,
        dataSource: json['dataSource'] == null
            ? null
            : InteractionDataSource.fromJson(json['dataSource'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'dataSource': dataSource?.toJson(),
      };
}
