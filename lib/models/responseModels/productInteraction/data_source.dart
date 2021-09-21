import 'bought_product.dart';

class InteractionDataSource {
  List<BoughtProduct>? boughtProducts;
  List<dynamic>? cartProducts;
  List<dynamic>? viewedProducts;

  InteractionDataSource(
      {this.boughtProducts, this.cartProducts, this.viewedProducts});

  factory InteractionDataSource.fromJson(Map<String, dynamic> json) =>
      InteractionDataSource(
        boughtProducts: (json['bought_products'] as List<dynamic>?)
            ?.map((e) => BoughtProduct.fromJson(e as Map<String, dynamic>))
            .toList(),
        cartProducts: json['cart_products'] as List<dynamic>?,
        viewedProducts: json['viewed_products'] as List<dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        'bought_products': boughtProducts?.map((e) => e.toJson()).toList(),
        'cart_products': cartProducts,
        'viewed_products': viewedProducts,
      };
}
