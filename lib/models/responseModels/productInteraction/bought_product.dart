class BoughtProduct {
  String? productId;
  String? productName;
  String? productLink;
  List<dynamic>? productImages;
  double? unitPrice;
  int? timestamp;
  int? count;

  BoughtProduct({
    this.productId,
    this.productName,
    this.productLink,
    this.productImages,
    this.unitPrice,
    this.timestamp,
    this.count,
  });

  factory BoughtProduct.fromJson(Map<String, dynamic> json) => BoughtProduct(
        productId: json['product_id'] as String?,
        productName: json['product_name'] as String?,
        productLink: json['product_link'] as String?,
        productImages: json['product_images'] as List<dynamic>?,
        unitPrice: (json['unit_price'] as num?)?.toDouble(),
        timestamp: json['timestamp'] as int?,
        count: json['count'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'product_id': productId,
        'product_name': productName,
        'product_link': productLink,
        'product_images': productImages,
        'unit_price': unitPrice,
        'timestamp': timestamp,
        'count': count,
      };
}
