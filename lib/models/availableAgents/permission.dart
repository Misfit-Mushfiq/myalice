class Permission {
  int? id;
  String? shortCode;
  String? verbose;

  Permission({this.id, this.shortCode, this.verbose});

  factory Permission.fromJson(Map<String, dynamic> json) => Permission(
        id: json['id'] as int?,
        shortCode: json['short_code'] as String?,
        verbose: json['verbose'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'short_code': shortCode,
        'verbose': verbose,
      };
}
