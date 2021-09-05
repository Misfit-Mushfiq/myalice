import 'data_source.dart';

class Channels {
  bool? success;
  List<ChannelDataSource>? dataSource;

  Channels({this.success, this.dataSource});

  factory Channels.fromJson(Map<String, dynamic> json) => Channels(
        success: json['success'] as bool?,
        dataSource: (json['dataSource'] as List<dynamic>?)
            ?.map((e) => ChannelDataSource.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'dataSource': dataSource?.map((e) => e.toJson()).toList(),
      };
}
