class Meta {
  String? age;
  String? consent;
  String? metaDefault;

  Meta({this.age, this.consent, this.metaDefault});

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        age: json['age'] as String?,
        consent: json['consent'] as String?,
        metaDefault: json['default'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'age': age,
        'consent': consent,
        'default': metaDefault,
      };
}
