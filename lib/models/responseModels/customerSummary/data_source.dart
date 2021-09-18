class SummaryDataSource {
  int? totalOrders;
  int? frequencyDays;
  double? lifetimeValue;
  double? averageValue;
  int? totalVisits;
  int? totalTickets;

  SummaryDataSource({
    this.totalOrders,
    this.frequencyDays,
    this.lifetimeValue,
    this.averageValue,
    this.totalVisits,
    this.totalTickets,
  });

  factory SummaryDataSource.fromJson(Map<String, dynamic> json) => SummaryDataSource(
        totalOrders: json['total_orders'] as int?,
        frequencyDays: json['frequency_days'] as int?,
        lifetimeValue: (json['lifetime_value'] as num?)?.toDouble(),
        averageValue: (json['average_value'] as num?)?.toDouble(),
        totalVisits: json['total_visits'] as int?,
        totalTickets: json['total_tickets'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'total_orders': totalOrders,
        'frequency_days': frequencyDays,
        'lifetime_value': lifetimeValue,
        'average_value': averageValue,
        'total_visits': totalVisits,
        'total_tickets': totalTickets,
      };
}
