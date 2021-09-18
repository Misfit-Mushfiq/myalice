class PaymentLine {
  String? methodId;
  String? methodTitle;
  bool? isEnabled;

  PaymentLine({this.methodId, this.methodTitle, this.isEnabled});

  factory PaymentLine.fromJson(Map<String, dynamic> json) => PaymentLine(
        methodId: json['method_id'] as String?,
        methodTitle: json['method_title'] as String?,
        isEnabled: json['is_enabled'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'method_id': methodId,
        'method_title': methodTitle,
        'is_enabled': isEnabled,
      };
}
