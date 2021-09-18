import 'billing_address.dart';
import 'payment_line.dart';
import 'product.dart';
import 'shipping_address.dart';
import 'shipping_line.dart';

class OrderDataSource {
  String? id;
  String? createdAt;
  String? modifiedAt;
  String? ecommerceType;
  String? ecommerceStoreUrl;
  String? ecommerceAccountId;
  String? ecommerceOrderId;
  List<Product>? products;
  double? totalCost;
  String? status;
  String? permalink;
  String? checkoutLink;
  String? paymentLink;
  double? totalTax;
  double? totalDiscount;
  double? totalRefund;
  double? totalShippingCost;
  String? shippingMethod;
  ShippingLine? shippingLine;
  String? paymentMethod;
  PaymentLine? paymentLine;
  List<dynamic>? couponInfo;
  dynamic dateCompleted;
  dynamic datePaid;
  BillingAddress? billingAddress;
  ShippingAddress? shippingAddress;

  OrderDataSource({
    this.id,
    this.createdAt,
    this.modifiedAt,
    this.ecommerceType,
    this.ecommerceStoreUrl,
    this.ecommerceAccountId,
    this.ecommerceOrderId,
    this.products,
    this.totalCost,
    this.status,
    this.permalink,
    this.checkoutLink,
    this.paymentLink,
    this.totalTax,
    this.totalDiscount,
    this.totalRefund,
    this.totalShippingCost,
    this.shippingMethod,
    this.shippingLine,
    this.paymentMethod,
    this.paymentLine,
    this.couponInfo,
    this.dateCompleted,
    this.datePaid,
    this.billingAddress,
    this.shippingAddress,
  });

  factory OrderDataSource.fromJson(Map<String, dynamic> json) => OrderDataSource(
        id: json['id'] as String?,
        createdAt: json['created_at'] as String?,
        modifiedAt: json['modified_at'] as String?,
        ecommerceType: json['ecommerce_type'] as String?,
        ecommerceStoreUrl: json['ecommerce_store_url'] as String?,
        ecommerceAccountId: json['ecommerce_account_id'] as String?,
        ecommerceOrderId: json['ecommerce_order_id'] as String?,
        products: (json['products'] as List<dynamic>?)
            ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
            .toList(),
        totalCost: (json['total_cost'] as num?)?.toDouble(),
        status: json['status'] as String?,
        permalink: json['permalink'] as String?,
        checkoutLink: json['checkout_link'] as String?,
        paymentLink: json['payment_link'] as String?,
        totalTax: json['total_tax'] as double?,
        totalDiscount: json['total_discount'] as double?,
        totalRefund: json['total_refund'] as double?,
        totalShippingCost: (json['total_shipping_cost'] as num?)?.toDouble(),
        shippingMethod: json['shipping_method'] as String?,
        shippingLine: json['shipping_line'] == null
            ? null
            : ShippingLine.fromJson(
                json['shipping_line'] as Map<String, dynamic>),
        paymentMethod: json['payment_method'] as String?,
        paymentLine: json['payment_line'] == null
            ? null
            : PaymentLine.fromJson(
                json['payment_line'] as Map<String, dynamic>),
        couponInfo: json['coupon_info'] as List<dynamic>?,
        dateCompleted: json['date_completed'] as dynamic?,
        datePaid: json['date_paid'] as dynamic?,
        billingAddress: json['billing_address'] == null
            ? null
            : BillingAddress.fromJson(
                json['billing_address'] as Map<String, dynamic>),
        shippingAddress: json['shipping_address'] == null
            ? null
            : ShippingAddress.fromJson(
                json['shipping_address'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'created_at': createdAt,
        'modified_at': modifiedAt,
        'ecommerce_type': ecommerceType,
        'ecommerce_store_url': ecommerceStoreUrl,
        'ecommerce_account_id': ecommerceAccountId,
        'ecommerce_order_id': ecommerceOrderId,
        'products': products?.map((e) => e.toJson()).toList(),
        'total_cost': totalCost,
        'status': status,
        'permalink': permalink,
        'checkout_link': checkoutLink,
        'payment_link': paymentLink,
        'total_tax': totalTax,
        'total_discount': totalDiscount,
        'total_refund': totalRefund,
        'total_shipping_cost': totalShippingCost,
        'shipping_method': shippingMethod,
        'shipping_line': shippingLine?.toJson(),
        'payment_method': paymentMethod,
        'payment_line': paymentLine?.toJson(),
        'coupon_info': couponInfo,
        'date_completed': dateCompleted,
        'date_paid': datePaid,
        'billing_address': billingAddress?.toJson(),
        'shipping_address': shippingAddress?.toJson(),
      };
}
