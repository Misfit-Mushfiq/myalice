class Product {
  String? productId;
  String? productName;
  String? productLink;
  List<dynamic>? productImages;
  bool? hasVariations;
  String? sku;
  String? variantId;
  List<dynamic>? variantAttributes;
  String? variantAttributesString;
  int? quantity;
  double? unitPrice;
  double? totalCost;
  dynamic timestamp;

  Product({
    this.productId,
    this.productName,
    this.productLink,
    this.productImages,
    this.hasVariations,
    this.sku,
    this.variantId,
    this.variantAttributes,
    this.variantAttributesString,
    this.quantity,
    this.unitPrice,
    this.totalCost,
    this.timestamp,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json['product_id'] as String?,
        productName: json['product_name'] as String?,
        productLink: json['product_link'] as String?,
        productImages: json['product_images'] as List<dynamic>?,
        hasVariations: json['has_variations'] as bool?,
        sku: json['sku'] as String?,
        variantId: json['variant_id'] as String?,
        variantAttributes: json['variant_attributes'] as List<dynamic>?,
        variantAttributesString: json['variant_attributes_string'] as String?,
        quantity: json['quantity'] as int?,
        unitPrice: json['unit_price'] as double?,
        totalCost: json['total_cost'] as double?,
        timestamp: json['timestamp'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'product_id': productId,
        'product_name': productName,
        'product_link': productLink,
        'product_images': productImages,
        'has_variations': hasVariations,
        'sku': sku,
        'variant_id': variantId,
        'variant_attributes': variantAttributes,
        'variant_attributes_string': variantAttributesString,
        'quantity': quantity,
        'unit_price': unitPrice,
        'total_cost': totalCost,
        'timestamp': timestamp,
      };
}
