class AvailableGroups {
  bool? success;
  List<dynamic>? dataSource;

  AvailableGroups({this.success, this.dataSource});

  factory AvailableGroups.fromJson(Map<String, dynamic> json) =>
      AvailableGroups(
        success: json['success'] as bool?,
        dataSource: json['dataSource'] as List<dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'dataSource': dataSource,
      };
}
