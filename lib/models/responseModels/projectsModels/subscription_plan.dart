class SubscriptionPlan {
  int? id;
  String? name;
  List<dynamic>? features;
  String? currency;
  String? interval;
  String? price;
  int? maxMau;
  String? planType;

  SubscriptionPlan({
    this.id,
    this.name,
    this.features,
    this.currency,
    this.interval,
    this.price,
    this.maxMau,
    this.planType,
  });

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) =>
      SubscriptionPlan(
        id: json['id'] as int?,
        name: json['name'] as String?,
        features: json['features'] as List<dynamic>?,
        currency: json['currency'] as String?,
        interval: json['interval'] as String?,
        price: json['price'] as String?,
        maxMau: json['max_mau'] as int?,
        planType: json['plan_type'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'features': features,
        'currency': currency,
        'interval': interval,
        'price': price,
        'max_mau': maxMau,
        'plan_type': planType,
      };
}
