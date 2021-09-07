import 'creator.dart';
import 'nlp_info.dart';
import 'platform.dart';
import 'subscription_plan.dart';

class ProjectDataSource {
  int? id;
  String? name;
  dynamic description;
  String? slug;
  String? image;
  String? nlpEngine;
  NlpInfo? nlpInfo;
  double? nlpConfidence;
  List<Platform>? platforms;
  bool? isSharable;
  bool? isCreator;
  bool? isPro;
  String? billingState;
  bool? isDowngrading;
  SubscriptionPlan? subscriptionPlan;
  String? lastBillingDate;
  int? monthlyActiveUsers;
  Creator? creator;
  bool? hasEcommerceConnected;
  String? ecommercePlatformType;

  ProjectDataSource({
    this.id,
    this.name,
    this.description,
    this.slug,
    this.image,
    this.nlpEngine,
    this.nlpInfo,
    this.nlpConfidence,
    this.platforms,
    this.isSharable,
    this.isCreator,
    this.isPro,
    this.billingState,
    this.isDowngrading,
    this.subscriptionPlan,
    this.lastBillingDate,
    this.monthlyActiveUsers,
    this.creator,
    this.hasEcommerceConnected,
    this.ecommercePlatformType,
  });

  factory ProjectDataSource.fromJson(Map<String, dynamic> json) =>
      ProjectDataSource(
        id: json['id'] as int?,
        name: json['name'] as String?,
        description: json['description'],
        slug: json['slug'] as String?,
        image: json['image'] as String?,
        nlpEngine: json['nlp_engine'] as String?,
        nlpInfo: json['nlp_info'] == null
            ? null
            : NlpInfo.fromJson(json['nlp_info'] as Map<String, dynamic>),
        nlpConfidence: json['nlp_confidence'] as double?,
        platforms: (json['platforms'] as List<dynamic>?)
            ?.map((e) => Platform.fromJson(e as Map<String, dynamic>))
            .toList(),
        isSharable: json['is_sharable'] as bool?,
        isCreator: json['is_creator'] as bool?,
        isPro: json['is_pro'] as bool?,
        billingState: json['billing_state'] as String?,
        isDowngrading: json['is_downgrading'] as bool?,
        subscriptionPlan: json['subscription_plan'] == null
            ? null
            : SubscriptionPlan.fromJson(
                json['subscription_plan'] as Map<String, dynamic>),
        lastBillingDate: json['last_billing_date'] as String?,
        monthlyActiveUsers: json['monthly_active_users'] as int?,
        creator: json['creator'] == null
            ? null
            : Creator.fromJson(json['creator'] as Map<String, dynamic>),
        hasEcommerceConnected: json['has_ecommerce_connected'] as bool?,
        ecommercePlatformType: json['ecommerce_platform_type'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'slug': slug,
        'image': image,
        'nlp_engine': nlpEngine,
        'nlp_info': nlpInfo?.toJson(),
        'nlp_confidence': nlpConfidence,
        'platforms': platforms?.map((e) => e.toJson()).toList(),
        'is_sharable': isSharable,
        'is_creator': isCreator,
        'is_pro': isPro,
        'billing_state': billingState,
        'is_downgrading': isDowngrading,
        'subscription_plan': subscriptionPlan?.toJson(),
        'last_billing_date': lastBillingDate,
        'monthly_active_users': monthlyActiveUsers,
        'creator': creator?.toJson(),
        'has_ecommerce_connected': hasEcommerceConnected,
        'ecommerce_platform_type': ecommercePlatformType,
      };
}
