class ShippingLine {
  String? methodId;
  String? methodTitle;
  double? shippingCost;
  String? source;

  ShippingLine({
    this.methodId,
    this.methodTitle,
    this.shippingCost,
    this.source,
  });

  factory ShippingLine.fromJson(Map<String, dynamic> json) => ShippingLine(
        methodId: json['method_id'] as String?,
        methodTitle: json['method_title'] as String?,
        shippingCost: json['shipping_cost'] as double?,
        source: json['source'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'method_id': methodId,
        'method_title': methodTitle,
        'shipping_cost': shippingCost,
        'source': source,
      };
}
